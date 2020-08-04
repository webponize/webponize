import Cocoa
import WebP
import Defaults

class ConvertOperation: Operation {
    var uuid = UUID().uuidString
    var fileURL: URL
    var destURL: URL {
        let folder = fileURL.deletingLastPathComponent()
        let file = fileURL.lastPathComponent.replacingOccurrences(
            of: fileURL.pathExtension,
            with: "webp",
            options: .caseInsensitive,
            range: nil
        )

        return folder.appendingPathComponent(file)
    }
        
    init(_ fileURL: URL) {
        self.fileURL = fileURL

        super.init()
    }

    override func main() {
        if isCancelled {
            return
        }

        guard let status = AppDelegate.statusList.filter({ $0.operation.uuid == uuid }).first else {
            return
        }

        let encoder = WebPEncoder()
        var config = WebPEncoderConfig.preset(WebPEncoderConfig.Preset.default, quality: Defaults[.quality])
        config.method = Defaults[.speed]
        config.lossless = Defaults[.lossless]

        do {
            let input = try Data(contentsOf: fileURL)
            guard let image = NSImage(data: input) else {
                status.status = StatusType.error
                return
            }
            let output = try encoder.encode(image, config: config)
            NSData(data: output).write(to: destURL, atomically: true)
            
            status.beforeByte = input.count
            status.afterByte = output.count
            status.status = StatusType.finished
        } catch {
            status.status = StatusType.error
        }
    }
}
