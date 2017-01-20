import Cocoa

class DropAreaView: NSImageView {
    var dropImage = NSImage(named: "drop-area")
    var dropImageHover = NSImage(named: "drop-area-hover")

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.image = dropImage
    }
    
    func setHoverImage() {
        self.image = dropImageHover
    }
    
    func setImage() {
        self.image = dropImage
    }
}
