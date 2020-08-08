import Foundation
import Cocoa

class ConvertManager {
    static func openSavePanel(for sheetWindow: NSWindow, target url: URL) {
        ConvertManager.openSavePanel(for: sheetWindow, target: [url])
    }
    
    static func openSavePanel(for sheetWindow: NSWindow, target urls: [URL]) {
        let openPanel = NSOpenPanel()
        openPanel.canChooseFiles = false
        openPanel.canChooseDirectories = true
        openPanel.canCreateDirectories = true
        openPanel.beginSheetModal(for: sheetWindow) { (response: NSApplication.ModalResponse) -> Void in
            if response != NSApplication.ModalResponse.OK {
                return
            }
            
            guard let selectedUrl = openPanel.url else {
                return
            }
            
            for url in urls {
                ConvertManager.addFile(targetFile: url, destinationFolder: selectedUrl)
            }
        }
    }
    
    static func addFile(targetFiles: [URL], destinationFolder: URL) {
        for targetFile in targetFiles {
            ConvertManager.addFile(targetFile: targetFile, destinationFolder: destinationFolder)
        }
    }
    
    static func addFile(targetFile: URL, destinationFolder: URL) {
        let operation = ConvertOperation(targetFile: targetFile, destinationFolder: destinationFolder)
        let status = Status(operation)
        
        AppDelegate.statusList.append(status)
        AppDelegate.queue.addOperation(operation)
    }
}
