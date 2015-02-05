import Cocoa

class PreferenceViewController: NSViewController {
    
    @IBOutlet weak var compressionLevel: NSSlider!
    
    @IBOutlet weak var isLossless: NSButton!
    
    @IBOutlet weak var isNoAlpha: NSButton!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onCompressionLevelChanged(sender: NSSlider) {
        println(sender)
    }
    
    @IBAction func onLosslessClicked(sender: NSButton) {
        println(sender)
    }
    
    @IBAction func onNoAlphaClicked(sender: NSButton) {
        println(sender)
    }
}
