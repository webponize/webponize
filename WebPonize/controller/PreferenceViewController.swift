import Cocoa

class PreferenceViewController: NSViewController {
    @IBOutlet weak var compressionLevelText: NSTextField!
    @IBOutlet weak var compressionLevel: NSSlider!
    @IBOutlet weak var isLossless: NSButton!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        compressionLevelText.intValue = Int32(AppDelegate.appConfig.compressionLevel)
        compressionLevel.intValue = Int32(AppDelegate.appConfig.compressionLevel)
        isLossless.intValue = Int32(AppDelegate.appConfig.lossless)
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        
        guard let window = view.window else {
            return
        }
    }
    
    @IBAction func onCompressionLevelTextChanged(_ sender: NSTextField) {
        compressionLevel.intValue = Int32(sender.intValue)
        AppDelegate.appConfig.compressionLevel = Float(sender.intValue)
    }
    
    override func controlTextDidChange(_ obj: Notification) {
        if obj.object as? NSTextField != compressionLevelText {
            return
        }

        compressionLevel.intValue = Int32(compressionLevelText.intValue)
        AppDelegate.appConfig.compressionLevel = Float(compressionLevelText.intValue)
    }
    
    @IBAction func onCompressionLevelChanged(_ sender: NSSlider) {
        let value = Int(sender.intValue)
        compressionLevelText.intValue = Int32(value)
        AppDelegate.appConfig.compressionLevel = Float(value)
    }
    
    @IBAction func onLosslessClicked(_ sender: NSButton) {
        AppDelegate.appConfig.lossless = Int(sender.intValue)
    }
}
