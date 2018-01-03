import Cocoa

class MainViewController: NSViewController {
    @IBOutlet weak var mainView: MainView!
    @IBOutlet weak var imageView: NSImageView!
    @IBOutlet weak var scrollView: NSScrollView!
    @IBOutlet weak var tableView: NSTableView!
    
    var imageDefault = NSImage(named: NSImage.Name(rawValue: "drop-area"))
    var imageHover = NSImage(named: NSImage.Name(rawValue: "drop-area-hover"))
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)

        AppDelegate.queue.addObserver(self, forKeyPath: "operations", options: .new, context: nil)
    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        DispatchQueue.main.async(execute: { [weak self] in
            self?.scrollView.isHidden = false
            self?.tableView.reloadData()
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.isHidden = true
        imageView.image = imageDefault
        
        mainView.onPerformDragOperation = { sender -> Void in
            let pboard = sender.draggingPasteboard()
            let type = NSPasteboard.PasteboardType(rawValue: "NSFilenamesPboardType")
            let filePaths = pboard.propertyList(forType: type) as! [String]

            let fileURLs = filePaths.map { filePath in
                return URL(fileURLWithPath: filePath)
            }
            
            for fileURL in fileURLs {
                Convert.addFile(fileURL)
            }
        }
        
        mainView.onDraggingEnteredHandler = { sender -> Void in
            self.imageView.image = self.imageHover
        }
        
        mainView.onDraggingExitedHandler = { sender -> Void in
            self.imageView.image = self.imageDefault
        }
        
        mainView.onDraggingEndedHandler = { sender -> Void in
            self.imageView.image = self.imageDefault
        }
    }
}

extension MainViewController: NSTableViewDelegate, NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        return AppDelegate.statusList.count
    }

    func tableView(_ tableView: NSTableView, objectValueFor tableColumn: NSTableColumn?, row rowIndex: Int) -> Any? {
        let data = AppDelegate.statusList[rowIndex]
        
        switch tableColumn!.identifier.rawValue {
        case "status":
            var image: NSImage?
            switch data.status {
            case StatusType.idle:
                image = NSImage(named: NSImage.Name(rawValue: "progress"))
            case StatusType.processing:
                image = NSImage(named: NSImage.Name(rawValue: "progress"))
            case StatusType.finished:
                image = NSImage(named: NSImage.Name(rawValue: "OK"))
            case StatusType.error:
                image = NSImage(named: NSImage.Name(rawValue: "error"))
            }
            return image
        case "file":
            return data.fileName
        case "size":
            return data.afterByte == 0 ? "" : data.afterByte
        case "savings":
            return data.savings
        default:
            return ""
        }
    }
}
