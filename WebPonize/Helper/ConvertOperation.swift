import Cocoa
import WebP

class ConvertOperation: Operation {
    var fileURL: URL
    var compressionLevel: Int
    var isLossless: Bool
    var isNoAlpha: Bool
    
    var fileName: String {
        return fileURL.lastPathComponent.replacingOccurrences(
            of: fileURL.pathExtension,
            with: "webp",
            options: .caseInsensitive,
            range: nil
        )
    }

    var folder: URL {
        return fileURL.deletingLastPathComponent()
    }
    
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

        let encoder = WebPEncoder()
        var config = WebPEncoderConfig.preset(WebPEncoderConfig.Preset.default, quality: Float(compressionLevel))
        config.lossless = isLossless ? 1 : 0

        let input = try! Data(contentsOf: fileURL)
        let output = try! encoder.encode(NSImage(data: input)!, config: config)
        NSData(data: output).write(to: folder.appendingPathComponent(fileName), atomically: true)
        
        var fileStatus: FileStatus?
        for fs in AppDelegate.fileStatusList {
            if fs.uuid == self.name {
                fileStatus = fs
            }
        }
        
        fileStatus?.beforeByteLength = input.count
        fileStatus?.afterByteLength = output.count

        if input.count > output.count {
            fileStatus?.status = FileStatusType.finished
        } else {
            fileStatus?.status = FileStatusType.error
        }
    }
}
