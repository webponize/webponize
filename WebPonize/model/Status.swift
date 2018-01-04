import Cocoa

enum StatusType: Int {
    case idle
    case processing
    case finished
    case error
}

class Status: NSObject {
    var status: StatusType = StatusType.idle
    var operation: ConvertOperation
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
    
    init(_ operation: ConvertOperation) {
        self.operation = operation
    }
}
