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
        
        compressionLevelText.intValue = Int32(AppDelegate.appConfig.compressionLevel)
        compressionLevel.intValue = Int32(AppDelegate.appConfig.compressionLevel)
        isLossless.intValue = AppDelegate.appConfig.isLossless ? 1 : 0
        isNoAlpha.intValue = AppDelegate.appConfig.isNoAlpha ? 1 : 0
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        
        guard let window = view.window else {
            return
        }
    }
    
    @IBAction func onCompressionLevelTextChanged(_ sender: NSTextField) {
        let value = Int(sender.intValue)
        compressionLevel.intValue = Int32(value)
        AppDelegate.appConfig.compressionLevel = value
    }
    
    override func controlTextDidChange(_ obj: Notification) {
        if obj.object as? NSTextField != compressionLevelText {
            return
        }

        let value = Int(self.compressionLevelText.intValue)
        compressionLevel.intValue = Int32(value)
        AppDelegate.appConfig.compressionLevel = value
    }
    
    @IBAction func onCompressionLevelChanged(_ sender: NSSlider) {
        let value = Int(sender.intValue)
        compressionLevelText.intValue = Int32(value)
        AppDelegate.appConfig.compressionLevel = value
    }
    
    @IBAction func onLosslessClicked(_ sender: NSButton) {
        let value = Bool(sender.intValue == 1)
        AppDelegate.appConfig.isLossless = value
    }
    
    @IBAction func onNoAlphaClicked(_ sender: NSButton) {
        let value = Bool(sender.intValue == 1)
        AppDelegate.appConfig.isNoAlpha = value
    }
}
