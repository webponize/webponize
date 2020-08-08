import Cocoa
import WebP
import Defaults

class ConvertOperation: Operation {
    var uuid = UUID().uuidString
    var targetFile: URL
    var destinationFolder: URL
    var destinationFile: URL {
        let fileName = targetFile.lastPathComponent.replacingOccurrences(
            of: targetFile.pathExtension,
            with: "webp",
            options: .caseInsensitive,
            range: nil
        )

        return destinationFolder.appendingPathComponent(fileName)
    }
        
    init(targetFile: URL, destinationFolder: URL) {
        self.targetFile = targetFile
        self.destinationFolder = destinationFolder

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
            let input = try Data(contentsOf: targetFile)
            guard let image = NSImage(data: input) else {
                status.status = StatusType.error
                return
            }
            
            let output = try encoder.encode(image, config: config)
            NSData(data: output).write(to: destinationFile, atomically: true)
            
            status.beforeByte = input.count
            status.afterByte = output.count
            status.status = StatusType.finished
        } catch {
            status.status = StatusType.error
        }
    }
}
