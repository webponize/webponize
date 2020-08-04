import Cocoa
import Defaults

class PreferenceViewController: NSViewController {
    @IBOutlet weak var quality: NSSlider!
    @IBOutlet weak var speed: NSSlider!
    @IBOutlet weak var lossless: NSButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        quality.intValue = Int32(Defaults[.quality])
        speed.intValue = Int32(Defaults[.speed])
        lossless.intValue = Int32(Defaults[.lossless])
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        self.view.window?.styleMask.remove(.resizable)
    }
        
    @IBAction func onQualityChanged(_ sender: NSSlider) {
        Defaults[.quality] = Float(sender.intValue)
    }
    
    @IBAction func onSpeedChanged(_ sender: NSSlider) {
        Defaults[.speed] = Int(sender.intValue)
    }
    
    @IBAction func onLosslessClicked(_ sender: NSButton) {
        Defaults[.lossless] = Int(sender.intValue)
    }
}
