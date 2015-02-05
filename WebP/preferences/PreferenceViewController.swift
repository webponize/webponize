import Cocoa

class PreferenceViewController: NSViewController {
    
    @IBOutlet weak var segmentControl: SegmentControl!
    
    @IBOutlet weak var generalView: GeneralView!

    @IBOutlet weak var cwebpView: CwebpView!

    @IBOutlet weak var dwebpView: DwebpView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func segmentIndexChanged(sender: SegmentedControl) {
        println(sender)
    }
}
