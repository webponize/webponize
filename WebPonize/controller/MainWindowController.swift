import Cocoa

class MainWindowController: NSWindowController {
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    @IBAction func openDocument(_ sender: AnyObject?) {
        let panel = NSOpenPanel()
        panel.canChooseDirectories = false
        panel.canCreateDirectories = false
        panel.canChooseFiles = true
        panel.allowsMultipleSelection = true
        panel.allowedFileTypes = ["jpg", "png", "gif"]
        
        panel.beginSheetModal(for: window!, completionHandler: {(result: NSApplication.ModalResponse) in
            if result != NSApplication.ModalResponse.OK {
                return
            }
            
            let compressionLevel = AppDelegate.appConfig.compressionLevel
            let lossless = AppDelegate.appConfig.lossless

            for item in panel.urls {
                let fileURL = URL(string: item.absoluteString as String!)!
                let uuid = UUID().uuidString

                AppDelegate.fileStatusList.append(
                    FileStatus(
                        uuid: uuid,
                        status: FileStatusType.idle,
                        fileURL: fileURL,
                        beforeByteLength: 0,
                        afterByteLength: 0
                    )
                )
                
                let operation = ConvertOperation(
                    uuid: uuid,
                    fileURL: fileURL,
                    compressionLevel: compressionLevel,
                    lossless: lossless)
                
                AppDelegate.operationQueue.addOperation(operation)
            }
        })
    }
}
