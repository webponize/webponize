import Cocoa

class DropViewController: NSViewController {

    @IBOutlet weak var dropView: DropView!
    
    @IBOutlet weak var dropAreaView: DropAreaView!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func loadView() {
        super.loadView()
        
        // load image and set it as view
        var dropImage = NSImage(contentsOfFile: "img/drop-area.png")
        self.dropAreaView.image = dropImage
    }
}
