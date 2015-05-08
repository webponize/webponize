import Cocoa

class PreferenceViewController: NSViewController {
    
    var config: ApplicationConfig = ApplicationConfig()
    
    @IBOutlet weak var compressionLevelText: NSTextField!
    
    @IBOutlet weak var compressionLevel: NSSlider!
    
    @IBOutlet weak var isLossless: NSButton!
    
    @IBOutlet weak var isNoAlpha: NSButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // prepare variables from configuration for UIs
        let compressionLevel: Int32 = Int32(config.getCompressionLevel())
        let isLossless: Int32 = config.getIsLossless() ? 1 : 0
        let isNoAlpha: Int32 = config.getIsNoAlpha() ? 1 : 0
        
        // set up default UI position
        self.compressionLevelText.intValue = compressionLevel
        self.compressionLevel.intValue = compressionLevel
        self.isLossless.intValue = isLossless
        self.isNoAlpha.intValue = isNoAlpha
    }
    
    @IBAction func onCompressionLevelTextChanged(sender: NSTextField) {
        let compressionLevel = Int(sender.intValue)
        self.compressionLevel.intValue = Int32(compressionLevel)
        self.config.setCompressionLevel(compressionLevel)
    }
    
    override func controlTextDidChange(obj: NSNotification) {
        if obj.object as? NSTextField != self.compressionLevelText {
            return
        }
        let compressionLevel = Int(self.compressionLevelText.intValue)
        self.compressionLevel.intValue = Int32(compressionLevel)
        config.setCompressionLevel(compressionLevel)
    }
    
    @IBAction func onCompressionLevelChanged(sender: NSSlider) {
        let compressionLevel = Int(sender.intValue)
        self.compressionLevelText.intValue = Int32(compressionLevel)
        self.config.setCompressionLevel(compressionLevel)
    }
    
    @IBAction func onLosslessClicked(sender: NSButton) {
        let isNoAlpha = Bool(sender.intValue == 1)
        config.setIsLossless(isNoAlpha)
    }
    
    @IBAction func onNoAlphaClicked(sender: NSButton) {
        let isNoAlpha = Bool(sender.intValue == 1)
        config.setIsNoAlpha(isNoAlpha)
    }
}
