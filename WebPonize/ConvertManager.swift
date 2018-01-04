import Foundation

class ConvertManager {
    static func addFile(_ fileURL: URL) {
        let operation = ConvertOperation(fileURL)
        let status = Status(operation)
        
        AppDelegate.statusList.append(status)
        AppDelegate.queue.addOperation(operation)
    }
}
