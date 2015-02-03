import Cocoa

class DashedLine: NSBox {

    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)
        
        
        NSColor.lightGrayColor().set()
        NSRectFill(dirtyRect)
    }
    
}
