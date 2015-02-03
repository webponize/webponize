import Cocoa

class DashedLine: NSBox {

    override func drawRect(dirtyRect: NSRect) {
        //super.drawRect(dirtyRect)
        
        NSColor.lightGrayColor().set()
        var path = NSBezierPath(rect: dirtyRect)
        path.lineWidth = 10.0
        
        let pattern: [CGFloat] = [5.0, 5.0]
        path.setLineDash(pattern, count: 2, phase: 0.0)
        path.stroke()
        
        //NSRectFill(dirtyRect)
    }
}
