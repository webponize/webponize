import Cocoa

class libwebp: NSObject {

    var attributes: [NSObject : AnyObject]?
    
    var inputFileURL: NSURL
    var inputData: NSData
    var inputImage: NSImage
    var inputBitmap: NSBitmapImageRep
    
    var inputFileName: String {
        get {
            return inputFileURL.path!.lastPathComponent
        }
    }
    var inputFolder: String {
        get {
            return inputFileURL.path!.stringByDeletingLastPathComponent
        }
    }
    var inputFilePath: String {
        get {
            return inputFolder.stringByAppendingPathComponent(inputFileName)
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
    
    var saveFileName: String {
        get {
            return inputFileName.stringByReplacingOccurrencesOfString(
                inputFileURL.path!.pathExtension,
                withString: "webp",
                options: .CaseInsensitiveSearch,
                range: nil
            )

        }
    }
    var saveFolder: String {
        get {
            return inputFileURL.path!.stringByDeletingLastPathComponent
        }
    }
    var saveFilePath: String {
        get {
            return saveFolder.stringByAppendingPathComponent(saveFileName)
        }
    }
    var saveFileURL: NSURL {
        get {
            return NSURL.fileURLWithPath(saveFilePath)!
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
        self.init(fileURL: NSURL.fileURLWithPath(filePath)!)
    }

    init(fileURL: NSURL) {
        
        inputFileURL = fileURL
        inputData = NSData(contentsOfURL: inputFileURL)!
        inputImage = NSImage(data: inputData)!
        inputBitmap = NSBitmapImageRep(data: inputData)!
        
        let manager: NSFileManager = NSFileManager.defaultManager()
        var error: NSError?
        
        attributes = manager.attributesOfFileSystemForPath(inputFileURL.path!, error: &error)
        
        if error != nil {
            println(error)
        }
        
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
        var range: NSRange = NSRange(location: 25, length: 1)

        data.getBytes(&c, range: range)
        
        return (c == 6);
    }
    
    private func getCGImage(image: NSImage) -> CGImage? {

        if let imageData = image.TIFFRepresentation {
            let source = CGImageSourceCreateWithData(imageData as CFDataRef, nil)
            let properties = CGImageSourceCopyPropertiesAtIndex(source, 0, nil) as CFDictionary
            return CGImageSourceCreateImageAtIndex(source, 0, properties)
        } else {
            return nil
        }
    }

    func encode(compressionLevel: Int, isLossless: Bool, isNoAlpha: Bool) -> Int {
        
        let image: CGImage? = getCGImage(inputImage)
        let imageType: ImageType = contentTypeForImageData(inputData)

        let provider: CGDataProviderRef = CGImageGetDataProvider(image)
        let bitmap: CFDataRef = CGDataProviderCopyData(provider)
    
        let rgb: UnsafePointer<UInt8> = CFDataGetBytePtr(bitmap)
        let width: Int32 = Int32(inputImageWidth)
        let height: Int32 = Int32(inputImageHeight)
        let stride: Int32 = Int32(CGImageGetBytesPerRow(image))
        let qualityFactor: Float = Float(compressionLevel)

        var webp: NSData
        var output: UnsafeMutablePointer<UInt8> = nil
        var size: size_t

        switch imageType {
        case ImageType.JPEG:
            size = WebPEncodeRGB(rgb, width, height, stride, qualityFactor, &output)
        case ImageType.PNG, ImageType.GIF, ImageType.TIFF:
            if isNoAlpha {
                size = WebPEncodeRGB(rgb, width, height, stride, qualityFactor, &output)
            } else {
                size = WebPEncodeRGBA(rgb, width, height, stride, qualityFactor, &output)
            }
        default:
            if isNoAlpha {
                size = WebPEncodeRGB(rgb, width, height, stride, qualityFactor, &output)
            } else {
                size = WebPEncodeRGBA(rgb, width, height, stride, qualityFactor, &output)
            }
        }
        
        afterByteLength = Int(size)
        webp = NSData(bytes: output, length: afterByteLength)
        webp.writeToURL(saveFileURL, atomically: true)
        free(output)
        
        return Int(size)
    }
}
