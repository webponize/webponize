import Cocoa

class WindowController: NSWindowController {

    override func windowDidLoad() {
        super.windowDidLoad()
    }

    func registerForDraggedTypes(pasteboardTypes: [AnyObject]) {
        println(pasteboardTypes)
    }
}
