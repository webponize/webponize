import Cocoa

class DropViewController: NSViewController, NSTableViewDelegate, NSTableViewDataSource {
    
    @IBOutlet weak var dropView: DropView!
    
    @IBOutlet weak var dropAreaView: DropAreaView!
    
    @IBOutlet weak var scrollView: NSScrollView!
    
    @IBOutlet weak var tableView: NSTableView!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        AppDelegate.operationQueue.addObserver(self, forKeyPath: "operations", options: .New, context: nil)
    }

    override func observeValueForKeyPath(keyPath: String, ofObject object: AnyObject, change: [NSObject : AnyObject], context: UnsafeMutablePointer<Void>) {
        scrollView.hidden = false
        tableView.reloadData()
    }
    
    func numberOfRowsInTableView(tableView: NSTableView) -> Int {
        return AppDelegate.fileStatusList.count
    }
    
    func tableView(tableView: NSTableView, willDisplayCell cell: AnyObject, forTableColumn tableColumn: NSTableColumn?, row: Int) {

        var textFieldCell = cell as! NSTextFieldCell
        textFieldCell.drawsBackground = true
        if row % 2 == 1 {
            textFieldCell.backgroundColor = NSColor.whiteColor()
        } else {
            textFieldCell.backgroundColor = NSColor(white: 0.95, alpha: 1.0)
        }
    }
    
    func tableView(tableView: NSTableView, objectValueForTableColumn tableColumn: NSTableColumn?, row rowIndex: Int) -> AnyObject? {
        
        let data: FileStatus =  AppDelegate.fileStatusList[rowIndex]
        
        switch tableColumn!.identifier {
        case "filePath":
            return data.fileURL.path
        case "fileName":
            return data.fileName
        case "beforeByteLength":
            return data.beforeByteLength
        case "afterByteLength":
            return data.afterByteLength
        case "savings":
            return data.savings
        default:
            return ""
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.hidden = true
        tableView.intercellSpacing = NSSize(width: 0, height: 0)

        //set in storyboard
        //tableView.setDataSource(self)
        //tableView.setDelegate(self)
        
        dropView.onPerformDragOperation = { sender -> Void in
            var filePaths = self.getDraggedFiles(sender)
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
    
    func getDraggedFiles(draggingInfo: NSDraggingInfo) -> [String] {
        let pboard = draggingInfo.draggingPasteboard()
        return pboard.propertyListForType(NSFilenamesPboardType) as! [String]
    }
    
    func convertFiles(filePaths: [String]) {

        let appConfig = AppDelegate.appConfig
        let compressionLevel = appConfig.getCompressionLevel()
        let isLossless = appConfig.getIsLossless()
        let isNoAlpha = appConfig.getIsNoAlpha()
        
        for filePath in filePaths {
            
            let fileURL = NSURL.fileURLWithPath(filePath)!
            let uuid = NSUUID().UUIDString
            
            AppDelegate.fileStatusList.append(
                FileStatus(
                    uuid: uuid,
                    status: FileStatusType.Idle,
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
