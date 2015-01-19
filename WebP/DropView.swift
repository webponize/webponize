import Cocoa

class DropView: NSView, NSDraggingDestination {
    
    override init(frame: NSRect) {
        super.init(frame: frame)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        registerForDraggedTypes([
            NSPasteboardTypePNG,
            NSColorPboardType,
            NSFilenamesPboardType
        ])
        //NSImage.imagePasteboardTypes()
        println(self.registeredDraggedTypes)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func drawRect(dirtyRect: NSRect)  {
        super.drawRect(dirtyRect)
        NSColor.whiteColor().set()
        NSRectFill(dirtyRect)
    }
    
    override func draggingEntered(sender: NSDraggingInfo) -> NSDragOperation  {
        println("draggingEntered")
        return NSDragOperation.Copy
    }
    
    override func draggingEnded(sender: NSDraggingInfo?) {
        println("draggingEnded")
    }
    
    override func performDragOperation(sender: NSDraggingInfo) -> Bool {
        
        let pboard = sender.draggingPasteboard()
        let draggedFilePaths = pboard.propertyListForType(NSFilenamesPboardType) as NSArray
        
        println(draggedFilePaths)
        
        let manager = NSFileManager.defaultManager()
        var error: NSError?
        for draggedFilePath in draggedFilePaths as [String] {
            let attributes = manager.attributesOfFileSystemForPath(draggedFilePath, error: &error)
            if error != nil {
                println("エラーでましてん…")
            } else {
                println(attributes)
            }
        }
        
        return true
    }
}
