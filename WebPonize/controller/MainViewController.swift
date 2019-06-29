import Cocoa

class MainViewController: NSViewController {
    @IBOutlet weak var mainView: MainView!
    @IBOutlet weak var imageView: NSImageView!
    @IBOutlet weak var scrollView: NSScrollView!
    @IBOutlet weak var tableView: NSTableView!
    
    var imageDefault = NSImage(named: "drop-area")
    var imageHover = NSImage(named: "drop-area-hover")
    var imageProgress = NSImage(named: "progress")
    var imageOk = NSImage(named: "OK")
    var imageError = NSImage(named: "error")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        scrollView.isHidden = true
        imageView.image = imageDefault
        
        mainView.onPerformDragOperation = { sender -> Void in
            let pboard = sender.draggingPasteboard
            let type = NSPasteboard.PasteboardType(rawValue: "NSFilenamesPboardType")
            let filePaths = pboard.propertyList(forType: type) as! [String]

            let fileURLs = filePaths.map { filePath in
                return URL(fileURLWithPath: filePath)
            }
            
            for fileURL in fileURLs {
                ConvertManager.addFile(fileURL)
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
        
        AppDelegate.queue.addObserver(self, forKeyPath: "operationCount", options: .new, context: nil)
    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        DispatchQueue.main.async {
            if self.scrollView.isHidden {
                self.scrollView.isHidden = false
            }

            self.tableView.reloadData()
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
            switch data.status {
            case StatusType.idle:
                return imageProgress
            case StatusType.processing:
                return imageProgress
            case StatusType.finished:
                return imageOk
            case StatusType.error:
                return imageError
            }
        case "file":
            return data.operation.destURL.lastPathComponent
        case "size":
            return data.afterByte == 0 ? "" : data.afterByte
        case "savings":
            return data.savings
        default:
            return ""
        }
    }
}
