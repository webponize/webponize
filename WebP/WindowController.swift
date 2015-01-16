import Cocoa

class WindowController: NSWindowController {

    override func windowDidLoad() {
        super.windowDidLoad()
    
        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    }

    func registerForDraggedTypes(pasteboardTypes: [AnyObject]) {
        println(pasteboardTypes)
    }
}
