import Cocoa

class libwebp: NSObject {

    var attributes: [NSObject : AnyObject]?

    var inputFilePath: String
    var inputFileName: String
    var inputFileExtension: String
    var inputData: NSData
    var inputImage: NSImage {
        get {
            return NSImage(data: self.inputData)!
        }
    }
    
    var saveFileName: String
    var saveFolder: String
    var saveFilePath: String {
        get {
            return self.saveFolder + self.saveFileName
        }
    }
    
    private enum ImageType: String {
        case PNG = "image/png"
        case JPEG = "image/jpeg"
        case GIF = "image/gif"
        case TIFF = "image/tiff"
        case UNKNOWN = ""
    }

    init(filePath: String) {
        
        self.inputFilePath = filePath
        self.inputFileName = filePath.lastPathComponent
        self.inputFileExtension = filePath.pathExtension

        self.saveFileName = self.inputFileName.stringByReplacingOccurrencesOfString(
            self.inputFileExtension,
            withString: "webp",
            options: .CaseInsensitiveSearch,
            range: nil
        )

        self.saveFolder = filePath.stringByReplacingOccurrencesOfString(
            self.inputFileName,
            withString: "",
            options: .CaseInsensitiveSearch,
            range: nil
        )
        
        
        let manager: NSFileManager = NSFileManager.defaultManager()
        var error: NSError?
        
        self.attributes = manager.attributesOfFileSystemForPath(filePath, error: &error)
        
        if error != nil {
            println(error)
        }

        self.inputData = NSData(contentsOfFile: self.inputFilePath)!
        
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
    
    private func getCGImage(image: NSImage) -> CGImage? {

        if let imageData = image.TIFFRepresentation {
            let source = CGImageSourceCreateWithData(imageData as CFDataRef, nil)
            return CGImageSourceCreateImageAtIndex(source, UInt(0), nil)
        } else {
            return nil
        }
    }

    func encode(compressionLevel: Int, isLossless: Bool, isNoAlpha: Bool) {
        
        let image: CGImage? = getCGImage(self.inputImage)
        let imageType: ImageType = self.contentTypeForImageData(self.inputData)

        let provider: CGDataProviderRef = CGImageGetDataProvider(image)
        let bitmap: CFDataRef = CGDataProviderCopyData(provider)
    
        let rgb: UnsafePointer<UInt8> = CFDataGetBytePtr(bitmap)
        let width: Int32 = Int32(self.inputImage.size.width)
        let height: Int32 = Int32(self.inputImage.size.height)
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
        
        webp = NSData(bytes: output, length: Int(size))
        webp.writeToFile(self.saveFilePath, atomically: true)
        free(output)
    }

    private func decode() {
        
        var data: UInt8 = 0
        var dataSize: size_t = 0
        var width: Int32 = 0
        var height: Int32 = 0
        
        WebPDecodeRGB(&data, dataSize, &width, &height)
    }
}
