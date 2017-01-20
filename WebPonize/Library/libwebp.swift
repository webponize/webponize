import Cocoa

class libwebp: NSObject {
    var inputFileURL: URL
    var inputData: Data
    var inputImage: NSImage
    var inputBitmap: NSBitmapImageRep
    
    var inputFileName: String? {
        get {
            return inputFileURL.lastPathComponent
        }
    }

    var inputFolder: URL? {
        get {
            return inputFileURL.deletingLastPathComponent()
        }
    }

    var inputImageWidth: Int {
        get {
            return inputBitmap.pixelsWide
        }
    }

    var inputImageHeight: Int {
        get {
            return inputBitmap.pixelsHigh
        }
    }
    
    var saveFileName: String? {
        get {
            return inputFileName?.replacingOccurrences(
                of: inputFileURL.pathExtension,
                with: "webp",
                options: .caseInsensitive,
                range: nil
            )
        }
    }

    var saveFolder: URL? {
        return inputFileURL.deletingLastPathComponent()
    }

    var saveFileURL: URL? {
        get {
            guard let fileName = saveFileName else {
                return nil
            }

            return saveFolder?.appendingPathComponent(fileName)
        }
    }
    
    var beforeByteLength: Int {
        get {
            return inputData.count
        }
    }

    var afterByteLength: Int = 0
    
    fileprivate enum ImageType: String {
        case PNG = "image/png"
        case JPEG = "image/jpeg"
        case GIF = "image/gif"
        case TIFF = "image/tiff"
        case UNKNOWN = ""
    }
    
    convenience init(filePath: String) {
        self.init(fileURL: URL(fileURLWithPath: filePath))
    }

    init(fileURL: URL) {
        inputFileURL = fileURL
        inputData = try! Data(contentsOf: inputFileURL)
        inputImage = NSImage(data: inputData)!
        inputBitmap = NSBitmapImageRep(data: inputData)!

        super.init()
    }
    
    fileprivate func contentTypeForImageData(_ data: Data) -> ImageType {
        var c: UInt8 = 0
        (data as NSData).getBytes(&c, length: 1)
        
        switch c {
        case 0xFF:
            return ImageType.JPEG
        case 0x89:
            return ImageType.PNG
        case 0x47:
            return ImageType.GIF
        case 0x49:
            return ImageType.TIFF
        case 0x4D:
            return ImageType.TIFF
        default:
            return ImageType.UNKNOWN
        }
    }
    
    fileprivate func hasTransparencyForImageData(_ data: Data) -> Bool {
        var c: UInt8 = 0
        let range: NSRange = NSRange(location: 25, length: 1)

        (data as NSData).getBytes(&c, range: range)
        
        return (c == 6);
    }
    
    fileprivate func getCGImage(_ image: NSImage) -> CGImage? {
        guard let imageData = image.tiffRepresentation else {
            return nil
        }

        guard let source = CGImageSourceCreateWithData(imageData as CFData, nil) else {
            return nil
        }

        let properties = CGImageSourceCopyPropertiesAtIndex(source, 0, nil) as CFDictionary?
        return CGImageSourceCreateImageAtIndex(source, 0, properties)

    }

    func encode(_ compressionLevel: Int, isLossless: Bool, isNoAlpha: Bool) -> Int {
        let image: CGImage? = getCGImage(inputImage)
        let imageType: ImageType = contentTypeForImageData(inputData)

        let provider: CGDataProvider? = image?.dataProvider
        let bitmap: CFData? = provider?.data
    
        let rgb: UnsafePointer<UInt8> = CFDataGetBytePtr(bitmap)
        let width: Int32 = Int32(inputImageWidth)
        let height: Int32 = Int32(inputImageHeight)
        let stride: Int32 = Int32(image!.bytesPerRow)
        let qualityFactor: Float = Float(compressionLevel)

        var webp: Data
        var output: UnsafeMutablePointer<UInt8>? = nil
        var size: size_t = 0

        switch imageType {
        case ImageType.JPEG:
            size = WebPEncodeRGB(rgb, width, height, stride, qualityFactor, &output)
        case ImageType.PNG, ImageType.TIFF:
            if isNoAlpha {
                size = WebPEncodeRGB(rgb, width, height, stride, qualityFactor, &output)
            } else {
                size = WebPEncodeRGBA(rgb, width, height, stride, qualityFactor, &output)
            }
        case ImageType.GIF:
            if let saveFilePath = saveFileURL?.path {
                let gifConverter = gif2webp()
                gifConverter.currentDirectoryPath = (saveFileURL?.deletingLastPathComponent().path)!
                gifConverter.arguments = [inputFileURL.path, "-o", saveFilePath]
                gifConverter.execute()
                size = (try! Data(contentsOf: URL(fileURLWithPath: saveFilePath))).count
            }
        default:
            if isNoAlpha {
                size = WebPEncodeRGB(rgb, width, height, stride, qualityFactor, &output)
            } else {
                size = WebPEncodeRGBA(rgb, width, height, stride, qualityFactor, &output)
            }
        }

        afterByteLength = Int(size)
        
        if imageType != ImageType.GIF {
            if let url = saveFileURL {
                webp = Data(bytes: UnsafePointer<UInt8>(output!), count: afterByteLength)
                try? webp.write(to: url, options: [.atomic])
                free(output)
            }
        }
        
        return Int(size)
    }
}
