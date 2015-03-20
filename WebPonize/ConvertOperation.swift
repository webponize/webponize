import Cocoa

class ConvertOperation: NSOperation {
    
    let filePath: String
    let compressionLevel: Int
    let isLossless: Bool
    let isNoAlpha: Bool
    
    init(filePath: String, compressionLevel: Int, isLossless: Bool, isNoAlpha: Bool) {
        self.filePath = filePath
        self.compressionLevel = compressionLevel
        self.isLossless = isLossless
        self.isNoAlpha = isNoAlpha
        
        self.queuePriority = NSOperationQueuePriority.Normal
    }

    override func main() {
        
        if self.cancelled {
            return
        }
        
        let converter = libwebp(filePath: self.filePath)
        converter.encode(self.compressionLevel, isLossless: self.isLossless, isNoAlpha: self.isNoAlpha);
    }
}
