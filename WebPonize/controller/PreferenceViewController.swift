import Cocoa

class PreferenceViewController: NSViewController {
    
    @IBOutlet weak var compressionLevelText: NSTextField!
    
    @IBOutlet weak var compressionLevel: NSSlider!
    
    @IBOutlet weak var isLossless: NSButton!
    
    @IBOutlet weak var isNoAlpha: NSButton!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appConfig = AppDelegate.appConfig
        let compressionLevel: Int32 = Int32(appConfig.getCompressionLevel())
        let isLossless: Int32 = appConfig.getIsLossless() ? 1 : 0
        let isNoAlpha: Int32 = appConfig.getIsNoAlpha() ? 1 : 0
        
        self.compressionLevelText.intValue = compressionLevel
        self.compressionLevel.intValue = compressionLevel
        self.isLossless.intValue = isLossless
        self.isNoAlpha.intValue = isNoAlpha
    }
    
    @IBAction func onCompressionLevelTextChanged(sender: NSTextField) {
        let compressionLevel = Int(sender.intValue)
        self.compressionLevel.intValue = Int32(compressionLevel)
        AppDelegate.appConfig.setCompressionLevel(compressionLevel)
    }
    
    override func controlTextDidChange(obj: NSNotification) {
        if obj.object as? NSTextField != self.compressionLevelText {
            return
        }
        let compressionLevel = Int(self.compressionLevelText.intValue)
        self.compressionLevel.intValue = Int32(compressionLevel)
        AppDelegate.appConfig.setCompressionLevel(compressionLevel)
    }
    
    @IBAction func onCompressionLevelChanged(sender: NSSlider) {
        let compressionLevel = Int(sender.intValue)
        self.compressionLevelText.intValue = Int32(compressionLevel)
        AppDelegate.appConfig.setCompressionLevel(compressionLevel)
    }
    
    @IBAction func onLosslessClicked(sender: NSButton) {
        let isNoAlpha = Bool(sender.intValue == 1)
        AppDelegate.appConfig.setIsLossless(isNoAlpha)
    }
    
    @IBAction func onNoAlphaClicked(sender: NSButton) {
        let isNoAlpha = Bool(sender.intValue == 1)
        AppDelegate.appConfig.setIsNoAlpha(isNoAlpha)
    }
}
