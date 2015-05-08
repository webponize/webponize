import Cocoa

class MainWindowController: NSWindowController {

    var config: ApplicationConfig

    required init?(coder: NSCoder) {
        config = AppDelegate.getAppDelegate().config
        super.init(coder: coder)
    }
    
    @IBAction func openDocument(sender: AnyObject?) {
        
        let compressionLevel = config.getCompressionLevel()
        let isLossless = config.getIsLossless()
        let isNoAlpha = config.getIsNoAlpha()
        
        var queue = NSOperationQueue()
        queue.maxConcurrentOperationCount = 1

        var panel = NSOpenPanel()
        panel.canChooseDirectories = false
        panel.canCreateDirectories = false
        panel.canChooseFiles = true
        panel.allowsMultipleSelection = true
        panel.allowedFileTypes = ["jpg", "png", "gif"]
        
        panel.beginSheetModalForWindow(window!, completionHandler: {(result: Int) in

            if result != NSModalResponseOK {
                return
            }

            for url in panel.URLs {
                    
                var filePath = url.absoluteString as String!
                filePath = filePath.stringByReplacingOccurrencesOfString("file://", withString: "")
                    
                let operation = ConvertOperation(
                    filePath: filePath,
                    compressionLevel: compressionLevel,
                    isLossless: isLossless,
                    isNoAlpha: isNoAlpha
                )
                
                queue.addOperation(operation)
            }
        })
    }
}
