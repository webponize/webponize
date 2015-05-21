import Cocoa

class DropViewController: NSViewController {

    let config: ApplicationConfig

    @IBOutlet weak var dropView: DropView!
    
    @IBOutlet weak var dropAreaView: DropAreaView!
    
    required init?(coder: NSCoder) {
        config = AppDelegate.getAppDelegate().config
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dropView.onPerformDragOperation = { sender -> Void in
            var filePaths = self.getDraggedFiles(sender)
            self.convertFilesIntoWebP(filePaths)
        }
        
        self.dropView.onDraggingEnteredHandler = { sender -> Void in
            self.dropAreaView.setHoverImage()
        }
        
        self.dropView.onDraggingExitedHandler = { sender -> Void in
            self.dropAreaView.setImage()
        }
        
        self.dropView.onDraggingEndedHandler = { sender -> Void in
            self.dropAreaView.setImage()
        }
    }
    
    func getDraggedFiles(draggingInfo: NSDraggingInfo) -> [String] {
        let pboard = draggingInfo.draggingPasteboard()
        return pboard.propertyListForType(NSFilenamesPboardType) as! [String]
    }
    
    func convertFilesIntoWebP(filePaths: [String]) {

        let compressionLevel = config.getCompressionLevel()
        let isLossless = config.getIsLossless()
        let isNoAlpha = config.getIsNoAlpha()

        var queue = NSOperationQueue()
        queue.maxConcurrentOperationCount = 1
        
        for filePath in filePaths {
            
            let operation = ConvertOperation(
                filePath: filePath,
                compressionLevel: compressionLevel,
                isLossless: isLossless,
                isNoAlpha: isNoAlpha)
            
            queue.addOperation(operation)
        }

    }
}
