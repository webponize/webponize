import Cocoa

class DropView: NSView, NSDraggingDestination {
    
    var config: ApplicationConfig
        
    override init(frame: NSRect) {
        config = AppDelegate.getAppDelegate().config
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        config = AppDelegate.getAppDelegate().config
        super.init(coder: coder)
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        let acceptDragTypes = [
            NSPasteboardTypePNG,
            NSColorPboardType,
            NSFilenamesPboardType,
            NSImage.imageTypes()
        ] as [AnyObject]

        registerForDraggedTypes(acceptDragTypes)
    }
    
    override func performDragOperation(sender: NSDraggingInfo) -> Bool {
        
        let compressionLevel = config.getCompressionLevel()
        let isLossless = config.getIsLossless()
        let isNoAlpha = config.getIsNoAlpha()
        
        // get dragged files' path
        let pboard = sender.draggingPasteboard()
        let filePaths = pboard.propertyListForType(NSFilenamesPboardType) as! [String]
        
        // create operation & add into queue
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
        
        return true
    }
    
    var onDraggingEnteredHandler: ((sender: NSDraggingInfo) -> Void)?
    
    var onDraggingExitedHandler: ((sender: NSDraggingInfo) -> Void)?
    
    var onDraggingEndedHandler: ((sender: NSDraggingInfo) -> Void)?
    
    override func draggingEntered(sender: NSDraggingInfo) -> NSDragOperation  {
        // delegate to view controller
        onDraggingEnteredHandler?(sender: sender)
        return NSDragOperation.Copy
    }
    
    override func draggingExited(sender: NSDraggingInfo?) {
        // delegate to view controller
        onDraggingExitedHandler?(sender: sender!)
    }

    override func draggingEnded(sender: NSDraggingInfo?) {
        // delegate to view controller
        onDraggingEndedHandler?(sender: sender!)
    }
}
