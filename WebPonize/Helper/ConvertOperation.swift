import Cocoa

class ConvertOperation: Operation {
    var fileURL: URL
    var compressionLevel: Int
    var isLossless: Bool
    var isNoAlpha: Bool
    
    init(uuid: String, fileURL: URL, compressionLevel: Int, isLossless: Bool, isNoAlpha: Bool) {
        self.fileURL = fileURL
        self.compressionLevel = compressionLevel
        self.isLossless = isLossless
        self.isNoAlpha = isNoAlpha

        super.init()
        
        name = uuid
        queuePriority = Operation.QueuePriority.normal
    }

    override func main() {
        if self.isCancelled {
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
        let result = converter.encode(compressionLevel, isLossless: isLossless, isNoAlpha: isNoAlpha)
        fileStatus?.afterByteLength = converter.afterByteLength
        if result != 0 {
            fileStatus?.status = FileStatusType.finished
        } else {
            fileStatus?.status = FileStatusType.error
        }
    }
}
