import Cocoa

class PreferenceViewController: NSViewController {
    
    @IBOutlet weak var compressionLevel: CompressionLevelSlider!
    
    @IBOutlet weak var isLossless: LosslessCheckBox!
    
    @IBOutlet weak var isNoAlpha: NoAlphaCheckBox!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onCompressionLevelChanged(sender: CompressionLevelSlider) {
        println(sender)
    }
    
    @IBAction func onLosslessClicked(sender: LosslessCheckBox) {
        println(sender)
    }
    
    @IBAction func onNoAlphaClicked(sender: NoAlphaCheckBox) {
        println(sender)
    }
}
