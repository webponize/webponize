import Foundation

class ConvertManager {
    static func addFile(_ fileURL: URL) {
        let operation = ConvertOperation(fileURL: fileURL)
        let status = Status(
            uuid: operation.uuid,
            status: StatusType.idle,
            fileURL: fileURL,
            beforeByte: 0,
            afterByte: 0
        )
        
        AppDelegate.statusList.append(status)
        AppDelegate.queue.addOperation(operation)
    }
}
