import Cocoa

class DropAreaView: NSImageView {
    
    var dropImage = NSImage(named: "drop-area")
    var dropImageHover = NSImage(named: "drop-area-hover")

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        // load image and set it as view
        self.image = self.dropImage
    }
    
    func setHoverImage() {
        self.image = self.dropImageHover
    }
    
    func setImage() {
        self.image = self.dropImage
    }
}
