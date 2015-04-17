import Cocoa

class MainWindowController: NSWindowController {

    var config: ApplicationConfig

    required init?(coder: NSCoder) {

        // configure as default if not set
        self.config = AppDelegate.getAppDelegate().config
        super.init(coder: coder)
    }

    override func windowDidLoad() {
        super.windowDidLoad()
    }
    
    @IBAction func openDocument(sender: AnyObject?) {
        
        let compressionLevel: Int = self.config.getCompressionLevel()
        let isLossless: Bool = self.config.getIsLossless()
        let isNoAlpha: Bool = self.config.getIsNoAlpha()
        
        var queue = NSOperationQueue()
        queue.maxConcurrentOperationCount = 1

        let panel: NSOpenPanel = NSOpenPanel()
        panel.canChooseDirectories = false
        panel.canCreateDirectories = false
        panel.canChooseFiles = true
        panel.allowsMultipleSelection = true
        panel.allowedFileTypes = ["jpg", "png", "gif"]
        
        panel.beginSheetModalForWindow(self.window!, completionHandler: {(result: Int) in
            if result == NSModalResponseOK {

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
            }
        })
    }
}
