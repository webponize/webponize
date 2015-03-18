import Cocoa

class libwebp: NSObject {

    var attributes: [NSObject : AnyObject]

    var inputFilePath: String
    var inputFileName: String
    var inputFileExtension: String
    var inputImage: NSImage
    
    var saveFileName: String
    var saveFolder: String
    var saveFilePath: String {
        get {
            return self.saveFolder + self.saveFileName
        }
    }

    init(filePath: String) {
        
        self.inputFilePath = filePath
        self.inputFileName = filePath.lastPathComponent
        self.inputFileExtension = filePath.pathExtension

        self.saveFileName = self.inputFileName.stringByReplacingOccurrencesOfString(
            self.inputFileExtension, withString: "webp", options: .CaseInsensitiveSearch, range: nil)
        self.saveFolder = filePath.stringByReplacingOccurrencesOfString(
            self.inputFileName, withString: "", options: .CaseInsensitiveSearch, range: nil)
        
        
        let manager: NSFileManager = NSFileManager.defaultManager()
        var error: NSError?
        
        self.attributes = manager.attributesOfFileSystemForPath(filePath, error: &error)!
        
        if error != nil {
            println(error)
        }

        self.inputImage = NSImage(contentsOfFile: self.inputFilePath)!
        
        super.init()
    }
    
    private func getCGImage(image: NSImage) -> CGImage! {
        let imageData = image.TIFFRepresentation
        let source = CGImageSourceCreateWithData(imageData as CFDataRef, nil)
        return CGImageSourceCreateImageAtIndex(source, UInt(0), nil)
    }

    func encodeRGB() {
        
        let image = getCGImage(self.inputImage)
        let provider: CGDataProviderRef = CGImageGetDataProvider(image);
        let bitmap: CFDataRef = CGDataProviderCopyData(provider);
        
        let rgb: UnsafePointer<UInt8> = CFDataGetBytePtr(bitmap)
        let width: Int32 = Int32(self.inputImage.size.width)
        let height: Int32 = Int32(self.inputImage.size.height)
        let stride: Int32 = Int32(CGImageGetBytesPerRow(image))
        let qualityFactor: Float = 0.0

        var webp: NSData
        var output: UnsafeMutablePointer<UInt8> = nil
        
        WebPEncodeRGB(rgb, width, height, stride, qualityFactor, &output)
        webp = NSData(bytes: output, length: 0)
        webp.writeToFile(self.saveFilePath, atomically: true)
    }

    func encodeRGBA() {
        
        let image = getCGImage(self.inputImage)
        let provider: CGDataProviderRef = CGImageGetDataProvider(image);
        let bitmap: CFDataRef = CGDataProviderCopyData(provider);

        let rgb: UnsafePointer<UInt8> = CFDataGetBytePtr(bitmap)
        let width: Int32 = Int32(self.inputImage.size.width)
        let height: Int32 = Int32(self.inputImage.size.height)
        let stride: Int32 = Int32(CGImageGetBytesPerRow(image))
        let qualityFactor: Float = 0.0

        var webp: NSData
        var output: UnsafeMutablePointer<UInt8> = nil

        WebPEncodeRGBA(rgb, width, height, stride, qualityFactor, &output)
        webp = NSData(bytes: output, length: 0)
        webp.writeToFile(self.saveFilePath, atomically: true)
    }
    
    private func decodeRGB() {
        
        var data: UInt8 = 0
        var dataSize: size_t = 0
        var width: Int32 = 0
        var height: Int32 = 0
        
        WebPDecodeRGB(&data, dataSize, &width, &height)
    }

    private func decodeRGBA() {
        var data: UInt8 = 0
        var dataSize: size_t = 0
        var width: Int32 = 0
        var height: Int32 = 0
        
        WebPDecodeRGBA(&data, dataSize, &width, &height)
    }
}
