import Cocoa

class DropView: NSView, NSDraggingDestination {

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        let acceptDragTypes = [
            NSPasteboardTypePNG,
            NSColorPboardType,
            NSFilenamesPboardType
        ] as [AnyObject]

        registerForDraggedTypes(acceptDragTypes)
    }
    
    var onPerformDragOperation: ((sender: NSDraggingInfo) -> Void)?
    
    var onDraggingEnteredHandler: ((sender: NSDraggingInfo) -> Void)?
    
    var onDraggingExitedHandler: ((sender: NSDraggingInfo) -> Void)?
    
    var onDraggingEndedHandler: ((sender: NSDraggingInfo) -> Void)?
    
    override func performDragOperation(sender: NSDraggingInfo) -> Bool {
        onPerformDragOperation?(sender: sender)
        return true
    }
    
    override func draggingEntered(sender: NSDraggingInfo) -> NSDragOperation  {
        onDraggingEnteredHandler?(sender: sender)
        return NSDragOperation.Copy
    }
    
    override func draggingExited(sender: NSDraggingInfo?) {
        onDraggingExitedHandler?(sender: sender!)
    }

    override func draggingEnded(sender: NSDraggingInfo?) {
        onDraggingEndedHandler?(sender: sender!)
    }
}
