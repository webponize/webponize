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

        let acceptDragTypes = [
            NSPasteboardTypePNG,
            NSColorPboardType,
            NSFilenamesPboardType
            //NSImage.imagePasteboardTypes()
        ]

        registerForDraggedTypes(acceptDragTypes)
        //println(self.registeredDraggedTypes)
    }
    
    override func drawRect(dirtyRect: NSRect)  {
        super.drawRect(dirtyRect)
    }
    
    override func draggingEntered(sender: NSDraggingInfo) -> NSDragOperation  {
        // implementation when drag is entered
        return NSDragOperation.Copy
    }
    
    override func performDragOperation(sender: NSDraggingInfo) -> Bool {
        
        // get dragged files' path
        let pboard = sender.draggingPasteboard()
        let filePaths = pboard.propertyListForType(NSFilenamesPboardType) as NSArray
        
        // load dropped files using NSFileManager
        let manager = NSFileManager.defaultManager()
        var error: NSError?

        for filePath in filePaths as [String] {
            let attributes = manager.attributesOfFileSystemForPath(filePath, error: &error)
            if error != nil {
                println(error)
            } else {

                let fileName = filePath.lastPathComponent
                let fileExtension = filePath.pathExtension

                let saveName: String = fileName.stringByReplacingOccurrencesOfString(
                    fileExtension, withString: "webp", options: .CaseInsensitiveSearch, range: nil)
                let saveFolder: String = filePath.stringByReplacingOccurrencesOfString(
                    fileName, withString: "", options: .CaseInsensitiveSearch, range: nil)

                cwebp.setCurrentDirectoryPath(saveFolder)
                cwebp.setArguments(["-o", saveName, filePath])
                let standardOutput = cwebp.execute()

                //println(standardOutput)
            }
        }
        
        return true
    }

    override func draggingEnded(sender: NSDraggingInfo?) {
        // implementation when drag is ended
    }
}
