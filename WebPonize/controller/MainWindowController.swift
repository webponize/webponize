import Cocoa

class MainWindowController: NSWindowController {
    @IBAction func openDocument(_ sender: AnyObject?) {
        let panel = NSOpenPanel()
        panel.canChooseDirectories = false
        panel.canCreateDirectories = false
        panel.canChooseFiles = true
        panel.allowsMultipleSelection = true
        panel.allowedFileTypes = ["jpg", "png", "gif"]
        
        panel.beginSheetModal(for: window!, completionHandler: {(result: NSApplication.ModalResponse) in
            if result != NSApplication.ModalResponse.OK {
                return
            }

            for item in panel.urls {
                guard let fileURL = URL(string: item.absoluteString) else {
                    continue
                }
                
                Convert.addFile(fileURL)
            }
        })
    }
}
