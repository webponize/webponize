import Cocoa

class PreferenceView: NSView {
    override var acceptsFirstResponder: Bool {
        return true
    }
    
    override func becomeFirstResponder() -> Bool {
        return true
    }
    
    override func keyDown(with event: NSEvent) {
        guard let char = event.charactersIgnoringModifiers else {
            return
        }
        
        if event.modifierFlags.contains(.command) && char == "w" {
            window?.performClose(event)
        }
    }
}
