import Cocoa

class PreferenceViewController: NSViewController {
    
    var config: ApplicationConfig = ApplicationConfig()
    
    @IBOutlet weak var compressionLevel: CompressionLevelSlider!
    
    @IBOutlet weak var isLossless: LosslessCheckBox!
    
    @IBOutlet weak var isNoAlpha: NoAlphaCheckBox!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.compressionLevel.intValue = Int32(config.getCompressionLevel())
        self.isLossless.intValue = config.getIsLossless() ? 1 : 0
        self.isNoAlpha.intValue = config.getIsNoAlpha() ? 1 : 0
    }
    
    @IBAction func onCompressionLevelChanged(sender: CompressionLevelSlider) {
        self.config.setCompressionLevel(Int(sender.intValue))
    }
    
    @IBAction func onLosslessClicked(sender: LosslessCheckBox) {
        self.config.setIsLossless(sender.intValue == 1 ? true: false)
    }
    
    @IBAction func onNoAlphaClicked(sender: NoAlphaCheckBox) {
        self.config.setIsNoAlpha(sender.intValue == 1 ? true: false)
    }
}
