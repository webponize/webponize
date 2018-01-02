import Cocoa
import WebP

class ConvertOperation: Operation {
    var uuid = UUID().uuidString
    var fileURL: URL
    
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
    
    init(fileURL: URL) {
        self.fileURL = fileURL

        super.init()
        
        queuePriority = Operation.QueuePriority.normal
    }

    override func main() {
        if isCancelled {
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
