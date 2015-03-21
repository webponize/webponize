import Cocoa

class DropView: NSView, NSDraggingDestination {
    
    var config: ApplicationConfig = ApplicationConfig()
    
    override init(frame: NSRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        // configure as default if not set
        config.setDefaultValues()
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        let acceptDragTypes = [
            NSPasteboardTypePNG,
            NSColorPboardType,
            NSFilenamesPboardType
            //NSImage.imagePasteboardTypes()
        ]

        registerForDraggedTypes(acceptDragTypes)
    }
    
    override func performDragOperation(sender: NSDraggingInfo) -> Bool {
        
        let compressionLevel: Int = config.getCompressionLevel()
        let isLossless: Bool = config.getIsLossless()
        let isNoAlpha: Bool = config.getIsNoAlpha()
        
        // get dragged files' path
        let pboard: NSPasteboard = sender.draggingPasteboard()
        let filePaths: [String] = pboard.propertyListForType(NSFilenamesPboardType) as [String]
        
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
        self.onDraggingEnteredHandler?(sender: sender)
        
        return NSDragOperation.Copy
    }
    
    override func draggingExited(sender: NSDraggingInfo?) {
        
        // delegate to view controller
        self.onDraggingExitedHandler?(sender: sender!)
    }

    override func draggingEnded(sender: NSDraggingInfo?) {
        
        // delegate to view controller
        self.onDraggingEndedHandler?(sender: sender!)
    }
}
