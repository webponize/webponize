import Cocoa
import WebP

class ConvertOperation: Operation {
    var fileURL: URL
    var compressionLevel: Float
    var lossless: Int
    
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
    
    init(uuid: String, fileURL: URL, compressionLevel: Float, lossless: Int) {
        self.fileURL = fileURL
        self.compressionLevel = compressionLevel
        self.lossless = lossless

        super.init()
        
        name = uuid
        queuePriority = Operation.QueuePriority.normal
    }

    override func main() {
        if self.isCancelled {
            return
        }

        let encoder = WebPEncoder()
        var config = WebPEncoderConfig.preset(WebPEncoderConfig.Preset.default, quality: compressionLevel)
        config.lossless = lossless

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
