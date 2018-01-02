import Foundation

class Convert {
    static func addFile(_ fileURL: URL) {
        let operation = ConvertOperation(
            fileURL: fileURL,
            quality: AppDelegate.appConfig.quality,
            lossless: AppDelegate.appConfig.lossless
        )
        
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
