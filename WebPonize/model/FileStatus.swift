import Cocoa

enum FileStatusType: Int {
    case Idle
    case Processing
    case Finished
}

class FileStatus: NSObject {
    var uuid: String
    var status: FileStatusType
    var fileURL: NSURL
    var fileName: String {
        get {
            return fileURL.lastPathComponent!
        }
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
        var percent = 100 * Float(afterByteLength) / Float(beforeByteLength)

        return String(format:"%.1f％", percent)
    }
    
    init(uuid: String, status: FileStatusType, fileURL: NSURL, beforeByteLength: Int, afterByteLength: Int) {
        self.uuid = uuid
        self.status = status
        self.fileURL = fileURL
        self.beforeByteLength = beforeByteLength
        self.afterByteLength = afterByteLength
    }
}
