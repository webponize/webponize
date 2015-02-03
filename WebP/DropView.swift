import Cocoa

class DropView: NSView, NSDraggingDestination {
    
    var cwebp: Compress2Webp = Compress2Webp()
    
    override init(frame: NSRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
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
    
    override func drawRect(dirtyRect: NSRect)  {
        super.drawRect(dirtyRect)
    }
    
    override func draggingEntered(sender: NSDraggingInfo) -> NSDragOperation  {
        // implementation when drag is entered
        return NSDragOperation.Copy
    }
    
    override func performDragOperation(sender: NSDraggingInfo) -> Bool {
        
        // get dragged file paths
        let pboard = sender.draggingPasteboard()
        let filePaths = pboard.propertyListForType(NSFilenamesPboardType) as NSArray
        
        // load dropped file using NSFileManager
        let manager = NSFileManager.defaultManager()
        var error: NSError?

        for filePath in filePaths as [String] {
            let attributes = manager.attributesOfFileSystemForPath(filePath, error: &error)
            if error != nil {
                println(error)
            } else {

                let saveName: String = filePath.lastPathComponent.stringByReplacingOccurrencesOfString(filePath.pathExtension, withString: "webp", options: NSStringCompareOptions.CaseInsensitiveSearch, range: nil)
                let saveFolder: String = filePath.stringByReplacingOccurrencesOfString(filePath.lastPathComponent, withString: "", options: NSStringCompareOptions.CaseInsensitiveSearch, range: nil)

                cwebp.setCurrentDirectoryPath(saveFolder)
                cwebp.setArguments(["-o", saveName, filePath])

                println(cwebp.execute())
            }
        }
        
        return true
    }

    override func draggingEnded(sender: NSDraggingInfo?) {
        // implementation when drag is ended
    }
}
