import Cocoa

class DropViewController: NSViewController {

    @IBOutlet weak var dropView: DropView!
    
    @IBOutlet weak var dropAreaView: DropAreaView!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dropView.onDraggingEnteredHandler = { sender -> Void in
            println(sender)
        }
        
        self.dropView.onDraggingEndedHandler = { sender -> Void in
            println(sender)
        }
    }

    override func loadView() {
        super.loadView()
    }
    
    
}
