import Cocoa

enum FileStatusType: Int {
    case idle
    case processing
    case finished
    case error
}

class FileStatus: NSObject {
    var uuid: String
    var status: FileStatusType
    var fileURL: URL
    var fileName: String {
        return fileURL.lastPathComponent.replacingOccurrences(
            of: fileURL.pathExtension,
            with: "webp",
            options: .caseInsensitive,
            range: nil
        )
    }
    var beforeByteLength: Int = 0
    var afterByteLength: Int = 0
    var savings: String {
        if beforeByteLength == 0 {
            return ""
        }

        if afterByteLength == 0 {
            return ""
        }

        let percent = 100 * Float(afterByteLength) / Float(beforeByteLength)

        return String(format:"%.1f％", 100.0 - percent)
    }
    
    init(uuid: String, status: FileStatusType, fileURL: URL, beforeByteLength: Int, afterByteLength: Int) {
        self.uuid = uuid
        self.status = status
        self.fileURL = fileURL
        self.beforeByteLength = beforeByteLength
        self.afterByteLength = afterByteLength
    }
}
