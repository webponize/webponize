import Cocoa

class MainWindowController: NSWindowController {
    @IBAction func openDocument(_ sender: AnyObject?) {
        let panel = NSOpenPanel()
        panel.canChooseDirectories = false
        panel.canCreateDirectories = false
        panel.canChooseFiles = true
        panel.allowsMultipleSelection = true
        panel.allowedFileTypes = ["jpg", "png", "gif"]
        
        panel.beginSheetModal(for: window!, completionHandler: {(response: NSApplication.ModalResponse) in
            if response != NSApplication.ModalResponse.OK {
                return
            }
            
            ConvertManager.openSavePanel(for: self.window!, target: panel.urls)
        })
    }
}
