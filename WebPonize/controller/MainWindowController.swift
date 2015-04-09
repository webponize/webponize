import Cocoa

class MainWindowController: NSWindowController {

    let delegate: AppDelegate = NSApplication.sharedApplication().delegate as AppDelegate
    var config: ApplicationConfig

    required init?(coder: NSCoder) {

        // configure as default if not set
        self.config = self.delegate.config
        super.init(coder: coder)
    }

    override func windowDidLoad() {
        super.windowDidLoad()
    }
    
    @IBAction func openDocument(sender: AnyObject?) {
        
        println(self.config)
        
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
                
                for filePath in panel.URLs {
                    
                    println(filePath as String)
                    
                    //let operation = ConvertOperation(
                    //    filePath: filePath as String,
                    //    compressionLevel: 80,
                    //    isLossless: true,
                    //    isNoAlpha: true
                    //)
                    
                    //queue.addOperation(operation)
                }
            }
        })
    }
}
