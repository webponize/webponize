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
        
        panel.beginSheetModal(for: window!, completionHandler: {(result: Int) in
            if result != NSModalResponseOK {
                return
            }
            
            let compressionLevel = AppDelegate.appConfig.compressionLevel
            let isLossless = AppDelegate.appConfig.isLossless
            let isNoAlpha = AppDelegate.appConfig.isNoAlpha

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
                    isLossless: isLossless,
                    isNoAlpha: isNoAlpha)
                
                AppDelegate.operationQueue.addOperation(operation)
            }
        })
    }
}
