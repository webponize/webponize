import Cocoa

class DropView: NSView {
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        registerForDraggedTypes([
            NSPasteboard.PasteboardType.png,
            NSPasteboard.PasteboardType.color,
            NSPasteboard.PasteboardType.fileNameType(forPathExtension: "png"),
            NSPasteboard.PasteboardType.fileNameType(forPathExtension: "jpg")
        ])
    }
    
    var onPerformDragOperation: ((_ sender: NSDraggingInfo) -> Void)?
    
    var onDraggingEnteredHandler: ((_ sender: NSDraggingInfo) -> Void)?
    
    var onDraggingExitedHandler: ((_ sender: NSDraggingInfo) -> Void)?
    
    var onDraggingEndedHandler: ((_ sender: NSDraggingInfo) -> Void)?
    
    override func performDragOperation(_ sender: NSDraggingInfo) -> Bool {
        onPerformDragOperation?(sender)
        return true
    }
}

extension DropView {
    override func draggingEntered(_ sender: NSDraggingInfo) -> NSDragOperation  {
        onDraggingEnteredHandler?(sender)
        return NSDragOperation.copy
    }
    
    override func draggingExited(_ sender: NSDraggingInfo?) {
        onDraggingExitedHandler?(sender!)
    }

    override func draggingEnded(_ sender: NSDraggingInfo) {
        onDraggingEndedHandler?(sender)
    }
}
