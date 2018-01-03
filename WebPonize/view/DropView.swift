import Cocoa

class DropView: NSView {
    var onPerformDragOperation: ((_ sender: NSDraggingInfo) -> Void)?
    var onDraggingEnteredHandler: ((_ sender: NSDraggingInfo) -> Void)?
    var onDraggingExitedHandler: ((_ sender: NSDraggingInfo) -> Void)?
    var onDraggingEndedHandler: ((_ sender: NSDraggingInfo) -> Void)?

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        registerForDraggedTypes([.fileURL])
    }
}

extension DropView {
    override func performDragOperation(_ sender: NSDraggingInfo) -> Bool {
        onPerformDragOperation?(sender)
        return true
    }

    override func draggingEntered(_ sender: NSDraggingInfo) -> NSDragOperation  {
        onDraggingEnteredHandler?(sender)
        return NSDragOperation.generic
    }
    
    override func draggingExited(_ sender: NSDraggingInfo?) {
        onDraggingExitedHandler?(sender!)
    }

    override func draggingEnded(_ sender: NSDraggingInfo) {
        onDraggingEndedHandler?(sender)
    }
}
