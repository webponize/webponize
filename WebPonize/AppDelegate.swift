import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    static var appConfig = ApplicationConfig()

    static var fileStatusList: [FileStatus] = []
    
    static var operationQueue = OperationQueue()
    
    var mainWindow: NSWindow!
    
    override init() {
        super.init()
        AppDelegate.operationQueue.maxConcurrentOperationCount = 1
    }
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        mainWindow = NSApplication.shared().windows[0] 
    }
    
    func applicationShouldHandleReopen(_ sender: NSApplication, hasVisibleWindows flag: Bool) -> Bool {
        if !flag {
            mainWindow.makeKeyAndOrderFront(nil)
        }
        
        return true
    }
}
