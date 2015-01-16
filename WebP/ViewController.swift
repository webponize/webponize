import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var customButton: NSButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func onButtonClick(view: NSButton) {
        println(view)
    }
    
    
    func registerForDraggedTypes(pasteboardTypes: [AnyObject]) {
        println(pasteboardTypes)
    }
}

