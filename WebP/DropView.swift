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
        println("DropView::draggingEntered")
        return NSDragOperation.Copy
    }
    
    override func draggingEnded(sender: NSDraggingInfo?) {
        println("DropView::draggingEnded")
    }
    
    override func performDragOperation(sender: NSDraggingInfo) -> Bool {
        
        // get dragged file paths
        let pboard = sender.draggingPasteboard()
        let filePaths = pboard.propertyListForType(NSFilenamesPboardType) as NSArray
        println(filePaths)
        
        // load dropped file using NSFileManager
        let manager = NSFileManager.defaultManager()
        var error: NSError?

        for filePath in filePaths as [String] {
            let attributes = manager.attributesOfFileSystemForPath(filePath, error: &error)
            if error != nil {
                println("エラーでましてん…")
            } else {
                println(attributes)
            }
        }
        
        return true
    }
}
