import Cocoa
import Defaults
import Preferences

class GeneralPreferenceViewController: NSViewController, PreferencePane {
    @IBOutlet weak var quality: NSSlider!
    @IBOutlet weak var speed: NSSlider!
    @IBOutlet weak var lossless: NSButton!
    @IBOutlet weak var qualityLabel: NSTextField!
    @IBOutlet weak var speedLabel: NSTextField!
    
    let preferencePaneIdentifier = Preferences.PaneIdentifier.general
    let preferencePaneTitle = "General"
    let toolbarItemIcon = NSImage(named: NSImage.preferencesGeneralName)!
    
    override var nibName: NSNib.Name? { "GeneralPreferenceViewController" }

    override func viewDidLoad() {
        super.viewDidLoad()

        quality.intValue = Int32(Defaults[.quality])
        speed.intValue = Int32(Defaults[.speed])
        lossless.intValue = Int32(Defaults[.lossless])

        qualityLabel.stringValue = quality.stringValue
        speedLabel.stringValue = speed.stringValue
    }
            
    @IBAction func onQualityChanged(_ sender: NSSlider) {
        Defaults[.quality] = Float(sender.intValue)
        qualityLabel.stringValue = sender.stringValue
    }
    
    @IBAction func onSpeedChanged(_ sender: NSSlider) {
        Defaults[.speed] = Int(sender.intValue)
        speedLabel.stringValue = sender.stringValue
    }
    
    @IBAction func onLosslessClicked(_ sender: NSButton) {
        Defaults[.lossless] = Int(sender.intValue)
    }
}
