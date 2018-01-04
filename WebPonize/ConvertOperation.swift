import Cocoa
import WebP

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
        var config = WebPEncoderConfig.preset(WebPEncoderConfig.Preset.default, quality: AppDelegate.appConfig.quality)
        config.method = AppDelegate.appConfig.speed
        config.lossless = AppDelegate.appConfig.lossless
        config.filterStrength = AppDelegate.appConfig.filterStrength
        config.filterSharpness = AppDelegate.appConfig.filterSharpness
        config.filterType = AppDelegate.appConfig.filterType
        config.autofilter = AppDelegate.appConfig.autoFilter
        config.alphaQuality = AppDelegate.appConfig.alphaQuality
        config.alphaFiltering = AppDelegate.appConfig.alphaFiltering
        config.alphaCompression = AppDelegate.appConfig.alphaCompression

        do {
            let input = try Data(contentsOf: fileURL)
            let output = try encoder.encode(NSImage(data: input)!, config: config)
            NSData(data: output).write(to: destURL, atomically: true)
            
            status.beforeByte = input.count
            status.afterByte = output.count
            status.status = StatusType.finished
        } catch {
            status.status = StatusType.error
        }
    }
}
