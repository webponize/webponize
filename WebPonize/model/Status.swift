import Cocoa

enum StatusType: Int {
    case idle
    case processing
    case finished
    case error
}

class Status: NSObject {
    var uuid: String
    var status: StatusType
    var fileURL: URL
    var fileName: String {
        return fileURL.lastPathComponent.replacingOccurrences(
            of: fileURL.pathExtension,
            with: "webp",
            options: .caseInsensitive,
            range: nil
        )
    }
    var beforeByte: Int = 0
    var afterByte: Int = 0
    var savings: String {
        if beforeByte == 0 {
            return ""
        }

        if afterByte == 0 {
            return ""
        }

        let percent = 100 * Float(afterByte) / Float(beforeByte)

        return String(format:"%.1f％", 100.0 - percent)
    }
    
    init(uuid: String, status: StatusType, fileURL: URL, beforeByte: Int, afterByte: Int) {
        self.uuid = uuid
        self.status = status
        self.fileURL = fileURL
        self.beforeByte = beforeByte
        self.afterByte = afterByte
    }
}
