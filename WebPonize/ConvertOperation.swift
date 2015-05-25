import Cocoa

class ConvertOperation: NSOperation {
    
    var fileURL: NSURL
    var compressionLevel: Int
    var isLossless: Bool
    var isNoAlpha: Bool
    
    init(uuid: String, fileURL: NSURL, compressionLevel: Int, isLossless: Bool, isNoAlpha: Bool) {
        self.fileURL = fileURL
        self.compressionLevel = compressionLevel
        self.isLossless = isLossless
        self.isNoAlpha = isNoAlpha

        super.init()
        
        name = uuid
        queuePriority = NSOperationQueuePriority.Normal
    }

    override func main() {
        if self.cancelled {
            return
        }

        let converter = libwebp(fileURL: self.fileURL)
        var fileStatus: FileStatus?

        for fs in AppDelegate.fileStatusList {
            if fs.uuid == self.name {
                fileStatus = fs
            }
        }

        fileStatus?.beforeByteLength = converter.beforeByteLength
        converter.encode(compressionLevel, isLossless: isLossless, isNoAlpha: isNoAlpha)
        fileStatus?.afterByteLength = converter.afterByteLength
    }
}
