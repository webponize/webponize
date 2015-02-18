import Cocoa

class PreferenceViewController: NSViewController {
    
    var config: ApplicationConfig = ApplicationConfig()
    
    @IBOutlet weak var compressionLevel: CompressionLevelSlider!
    
    @IBOutlet weak var isLossless: LosslessCheckBox!
    
    @IBOutlet weak var isNoAlpha: NoAlphaCheckBox!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // prepare variables from configuration for UIs
        let compressionLevel: Int32 = Int32(config.getCompressionLevel())
        let isLossless: Int32 = config.getIsLossless() ? 1 : 0
        let isNoAlpha: Int32 = config.getIsNoAlpha() ? 1 : 0
        
        // set up default UI position
        self.compressionLevel.intValue = compressionLevel
        self.isLossless.intValue = isLossless
        self.isNoAlpha.intValue = isNoAlpha
    }
    
    @IBAction func onCompressionLevelChanged(sender: CompressionLevelSlider) {
        
        let compressionLevel: Int = Int(sender.intValue)
        
        self.config.setCompressionLevel(compressionLevel)
    }
    
    @IBAction func onLosslessClicked(sender: LosslessCheckBox) {
        
        let isNoAlpha: Bool = sender.intValue == 1 ? true : false
        
        self.config.setIsLossless(isNoAlpha)
    }
    
    @IBAction func onNoAlphaClicked(sender: NoAlphaCheckBox) {
        
        let isNoAlpha: Bool = sender.intValue == 1 ? true : false

        self.config.setIsNoAlpha(isNoAlpha)
    }
}
