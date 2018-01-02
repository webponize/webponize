import Cocoa

class PreferenceViewController: NSViewController {
    @IBOutlet weak var quality: NSSlider!
    @IBOutlet weak var speed: NSSlider!
    @IBOutlet weak var lossless: NSButton!
    
    @IBOutlet weak var filterStrength: NSSlider!
    @IBOutlet weak var filterSharpness: NSSlider!
    @IBOutlet weak var strongFilter: NSButton!
    @IBOutlet weak var autoFilter: NSButton!
    
    @IBOutlet weak var alphaQuality: NSSlider!
    @IBOutlet weak var alphaFiltering: NSSlider!
    @IBOutlet weak var alphaCompression: NSButton!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        quality.intValue = Int32(AppDelegate.appConfig.quality)
        speed.intValue = Int32(AppDelegate.appConfig.speed)
        lossless.intValue = Int32(AppDelegate.appConfig.lossless)
        
        filterStrength.intValue = Int32(AppDelegate.appConfig.filterStrength)
        filterSharpness.intValue = Int32(AppDelegate.appConfig.filterSharpness)
        strongFilter.intValue = Int32(AppDelegate.appConfig.filterType)
        autoFilter.intValue = Int32(AppDelegate.appConfig.autoFilter)
        
        alphaQuality.intValue = Int32(AppDelegate.appConfig.alphaQuality)
        alphaFiltering.intValue = Int32(AppDelegate.appConfig.alphaFiltering)
        alphaCompression.intValue = Int32(AppDelegate.appConfig.alphaCompression)
    }

    override func cancelOperation(_ sender: Any?) {
        view.window?.performClose(sender)
    }
    
    @IBAction func onQualityChanged(_ sender: NSSlider) {
        AppDelegate.appConfig.quality = Float(sender.intValue)
    }
    
    @IBAction func onSpeedChanged(_ sender: NSSlider) {
        AppDelegate.appConfig.speed = Int(sender.intValue)
    }
    
    @IBAction func onLosslessClicked(_ sender: NSButton) {
        AppDelegate.appConfig.lossless = Int(sender.intValue)
    }
    
    @IBAction func onFilterStrengthChanged(_ sender: NSSlider) {
        AppDelegate.appConfig.filterStrength = Int(sender.intValue)
    }
    
    @IBAction func onFilterSharpnessChanged(_ sender: NSSlider) {
        AppDelegate.appConfig.filterSharpness = Int(sender.intValue)
    }
    
    @IBAction func onStrongFilterClicked(_ sender: NSButton) {
        AppDelegate.appConfig.filterType = Int(sender.intValue)
    }
    
    @IBAction func onAutoFilterClicked(_ sender: NSButton) {
        AppDelegate.appConfig.autoFilter = Int(sender.intValue)
    }
    
    @IBAction func onAlphaQualityChanged(_ sender: NSSlider) {
        AppDelegate.appConfig.alphaQuality = Int(sender.intValue)
    }
    
    @IBAction func onAlphaFilteringChanged(_ sender: NSSlider) {
        AppDelegate.appConfig.alphaFiltering = Int(sender.intValue)
    }
    
    @IBAction func onAlphaCompressionClicked(_ sender: NSButton) {
        AppDelegate.appConfig.alphaCompression = Int(sender.intValue)
    }
}
