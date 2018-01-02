import Cocoa
import WebP

class ConvertOperation: Operation {
    var uuid = UUID().uuidString
    var fileURL: URL
    var quality: Float
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
    
    init(fileURL: URL, quality: Float, lossless: Int) {
        self.fileURL = fileURL
        self.quality = quality
        self.lossless = lossless

        super.init()
        
        queuePriority = Operation.QueuePriority.normal
    }

    override func main() {
        if isCancelled {
            return
        }

        let encoder = WebPEncoder()
        var config = WebPEncoderConfig.preset(WebPEncoderConfig.Preset.default, quality: quality)
        config.lossless = lossless

        let input = try! Data(contentsOf: fileURL)
        let output = try! encoder.encode(NSImage(data: input)!, config: config)
        NSData(data: output).write(to: folder.appendingPathComponent(fileName), atomically: true)
                
        let status = AppDelegate.statusList.filter({ $0.uuid == uuid }).first
        status?.beforeByte = input.count
        status?.afterByte = output.count

        if input.count > output.count {
            status?.status = StatusType.finished
        } else {
            status?.status = StatusType.error
        }
    }
}
