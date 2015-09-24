import Cocoa

class libwebp: NSObject {
    
    var inputFileURL: NSURL
    var inputData: NSData
    var inputImage: NSImage
    var inputBitmap: NSBitmapImageRep
    
    var inputFileName: String? {
        get {
            return inputFileURL.lastPathComponent
        }
    }
    var inputFolder: NSURL? {
        get {
            return inputFileURL.URLByDeletingLastPathComponent
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
            guard let pathExtenstion = inputFileURL.pathExtension else {
                return nil
            }
            return inputFileName?.stringByReplacingOccurrencesOfString(
                pathExtenstion,
                withString: "webp",
                options: .CaseInsensitiveSearch,
                range: nil
            )
        }
    }
    var saveFolder: NSURL? {
        get {
            return inputFileURL.URLByDeletingLastPathComponent
        }
    }
    var saveFileURL: NSURL? {
        get {
            guard let fileName = saveFileName else {
                return nil
            }
            return saveFolder?.URLByAppendingPathComponent(fileName)
        }
    }
    
    var beforeByteLength: Int {
        get {
            return inputData.length
        }
    }
    var afterByteLength: Int = 0
    
    private enum ImageType: String {
        case PNG = "image/png"
        case JPEG = "image/jpeg"
        case GIF = "image/gif"
        case TIFF = "image/tiff"
        case UNKNOWN = ""
    }
    
    convenience init(filePath: String) {
        self.init(fileURL: NSURL.fileURLWithPath(filePath))
    }

    init(fileURL: NSURL) {
        
        inputFileURL = fileURL
        inputData = NSData(contentsOfURL: inputFileURL)!
        inputImage = NSImage(data: inputData)!
        inputBitmap = NSBitmapImageRep(data: inputData)!

        super.init()
    }
    
    private func contentTypeForImageData(data: NSData) -> ImageType {
        
        var c: UInt8 = 0
        data.getBytes(&c, length: 1)
        
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
    
    private func hasTransparencyForImageData(data: NSData) -> Bool {
        
        var c: UInt8 = 0
        let range: NSRange = NSRange(location: 25, length: 1)

        data.getBytes(&c, range: range)
        
        return (c == 6);
    }
    
    private func getCGImage(image: NSImage) -> CGImageRef? {
        
        guard let imageData = image.TIFFRepresentation else {
            return nil
        }

        guard let source = CGImageSourceCreateWithData(imageData as CFDataRef, nil) else {
            return nil
        }

        let properties = CGImageSourceCopyPropertiesAtIndex(source, 0, nil) as CFDictionary?
        return CGImageSourceCreateImageAtIndex(source, 0, properties)

    }

    func encode(compressionLevel: Int, isLossless: Bool, isNoAlpha: Bool) -> Int {
        
        let image: CGImage? = getCGImage(inputImage)
        let imageType: ImageType = contentTypeForImageData(inputData)

        let provider: CGDataProviderRef? = CGImageGetDataProvider(image)
        let bitmap: CFDataRef? = CGDataProviderCopyData(provider)
    
        let rgb: UnsafePointer<UInt8> = CFDataGetBytePtr(bitmap)
        let width: Int32 = Int32(inputImageWidth)
        let height: Int32 = Int32(inputImageHeight)
        let stride: Int32 = Int32(CGImageGetBytesPerRow(image))
        let qualityFactor: Float = Float(compressionLevel)

        var webp: NSData
        var output: UnsafeMutablePointer<UInt8> = nil
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
            if let inputFilePath = inputFileURL.path, saveFilePath = saveFileURL?.path {
                let gifConverter = gif2webp()
                gifConverter.currentDirectoryPath = (saveFileURL?.URLByDeletingLastPathComponent?.path)!
                gifConverter.arguments = [inputFilePath, "-o", saveFilePath]
                gifConverter.execute()
                size = NSData(contentsOfFile: saveFilePath)!.length
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
                webp = NSData(bytes: output, length: afterByteLength)
                webp.writeToURL(url, atomically: true)
                free(output)
            }
        }
        
        return Int(size)
    }
}
