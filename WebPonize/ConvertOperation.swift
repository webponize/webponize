import Cocoa

class ConvertOperation: NSOperation {
    
    var filePath: String
    var compressionLevel: Int
    var isLossless: Bool
    var isNoAlpha: Bool
    
    init(filePath: String, compressionLevel: Int, isLossless: Bool, isNoAlpha: Bool) {
        self.filePath = filePath
        self.compressionLevel = compressionLevel
        self.isLossless = isLossless
        self.isNoAlpha = isNoAlpha

        super.init()
        self.queuePriority = NSOperationQueuePriority.Normal
    }

    override func main() {
        if self.cancelled {
            return
        }
        let converter = libwebp(filePath: filePath)
        converter.encode(compressionLevel, isLossless: isLossless, isNoAlpha: isNoAlpha)
    }
}
