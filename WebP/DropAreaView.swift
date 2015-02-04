import Cocoa

class DropAreaView: NSImageView {
    
    var hoverFilter: CIFilter = CIFilter(name: "CIColorControls")

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        // load image and set it as view
        self.image = NSImage(named: "drop-area")
        
        // initialize filter
        self.hoverFilter.setValue(1.0, forKey: "inputSaturation")
        self.hoverFilter.setValue(0.5, forKey: "inputBrightness")
        self.hoverFilter.setValue(3.0, forKey: "inputContrast")
    }
    
    func addFilter() {
        self.hoverFilter.setValue(self.image, forKey: kCIInputImageKey)
    }
    
    func removeFilter() {}
}
