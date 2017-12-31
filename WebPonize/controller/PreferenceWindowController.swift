import Cocoa

class PreferenceWindowController: NSWindowController {
    override func keyDown(with event: NSEvent) {
        guard let char = event.charactersIgnoringModifiers else {
            return
        }
        
        if event.modifierFlags.contains(.command) && char == "w" {
            close()
        }
    }
}
