import Cocoa

class DropAreaView: NSImageView {
    var dropImage = NSImage(named: NSImage.Name(rawValue: "drop-area"))
    var dropImageHover = NSImage(named: NSImage.Name(rawValue: "drop-area-hover"))

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
