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
            self.dropAreaView.setHoverImage()
        }
        
        self.dropView.onDraggingExitedHandler = { sender -> Void in
            self.dropAreaView.setImage()
        }
        
        self.dropView.onDraggingEndedHandler = { sender -> Void in
            self.dropAreaView.setImage()
        }
    }

    override func loadView() {
        super.loadView()
    }
}
