import Cocoa

class DropViewController: NSViewController {
    @IBOutlet weak var dropView: DropView!
    
    @IBOutlet weak var dropAreaView: DropAreaView!
    
    @IBOutlet weak var scrollView: NSScrollView!
    
    @IBOutlet weak var tableView: NSTableView!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        AppDelegate.operationQueue.addObserver(self, forKeyPath: "operations", options: .new, context: nil)
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
        
        dropView.onPerformDragOperation = { sender -> Void in
            let filePaths = self.getDraggedFiles(sender)
            self.convertFiles(filePaths)
        }
        
        dropView.onDraggingEnteredHandler = { sender -> Void in
            self.dropAreaView.setHoverImage()
        }
        
        dropView.onDraggingExitedHandler = { sender -> Void in
            self.dropAreaView.setImage()
        }
        
        dropView.onDraggingEndedHandler = { sender -> Void in
            self.dropAreaView.setImage()
        }
        
    }
    
    func getDraggedFiles(_ draggingInfo: NSDraggingInfo) -> [String] {
        let pboard = draggingInfo.draggingPasteboard()
        return pboard.propertyList(forType: NSPasteboard.PasteboardType.fileURL) as! [String]
    }
    
    func convertFiles(_ filePaths: [String]) {
        let compressionLevel = AppDelegate.appConfig.compressionLevel
        let isLossless = AppDelegate.appConfig.isLossless
        let isNoAlpha = AppDelegate.appConfig.isNoAlpha
        
        for filePath in filePaths {
            let fileURL = URL(fileURLWithPath: filePath)
            let uuid = UUID().uuidString
            
            AppDelegate.fileStatusList.append(
                FileStatus(
                    uuid: uuid,
                    status: FileStatusType.idle,
                    fileURL: fileURL,
                    beforeByteLength: 0,
                    afterByteLength: 0
                )
            )
            
            tableView.reloadData()

            let operation = ConvertOperation(
                uuid: uuid,
                fileURL: fileURL,
                compressionLevel: compressionLevel,
                isLossless: isLossless,
                isNoAlpha: isNoAlpha)
            
            AppDelegate.operationQueue.addOperation(operation)
        }
    }
}

extension DropViewController: NSTableViewDelegate, NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        return AppDelegate.fileStatusList.count
    }

    func tableView(_ tableView: NSTableView, objectValueFor tableColumn: NSTableColumn?, row rowIndex: Int) -> Any? {
        let data = AppDelegate.fileStatusList[rowIndex]
        
        switch tableColumn!.identifier.rawValue {
        case "status":
            var image: NSImage?
            switch data.status {
            case FileStatusType.idle:
                image = NSImage(named: NSImage.Name(rawValue: "progress"))
            case FileStatusType.processing:
                image = NSImage(named: NSImage.Name(rawValue: "progress"))
            case FileStatusType.finished:
                image = NSImage(named: NSImage.Name(rawValue: "ok"))
            case FileStatusType.error:
                image = NSImage(named: NSImage.Name(rawValue: "error"))
            }
            return image
        case "filePath":
            return data.fileURL.path
        case "fileName":
            return data.fileName
        case "beforeByteLength":
            return data.beforeByteLength
        case "afterByteLength":
            if data.afterByteLength == 0 {
                return ""
            }
            return data.afterByteLength
        case "savings":
            return data.savings
        default:
            return ""
        }
    }
}
