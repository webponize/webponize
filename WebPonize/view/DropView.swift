import Cocoa

class DropView: NSView {

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        let acceptDragTypes = [
            NSPasteboardTypePNG,
            NSColorPboardType,
            NSFilenamesPboardType
        ] as [String]

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
}

extension DropView {
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
