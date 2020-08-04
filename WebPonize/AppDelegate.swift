import Cocoa
import Defaults

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    static var statusList: [Status] = []
    static var queue = OperationQueue()
    
    var mainWindow: NSWindow?
    
    override init() {
        super.init()

        AppDelegate.queue.maxConcurrentOperationCount = 1
    }
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        mainWindow = NSApplication.shared.windows.first
    }
    
    func applicationShouldHandleReopen(_ sender: NSApplication, hasVisibleWindows flag: Bool) -> Bool {
        if !flag {
            mainWindow?.makeKeyAndOrderFront(nil)
        }
        
        return true
    }

    func application(_ sender: NSApplication, openFile filename: String) -> Bool {
        let fileURL = URL(fileURLWithPath: filename)
        ConvertManager.addFile(fileURL)
        return true
    }
}

extension Defaults.Keys {
    static let quality = Key<Float>("quality", default: 80)
    static let speed = Key<Int>("speed", default: 0)
    static let lossless = Key<Int>("lossless", default: 0)
}
