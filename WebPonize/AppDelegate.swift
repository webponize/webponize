import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    static var appConfig = ApplicationConfig()

    static var fileStatusList: [FileStatus] = []
    
    static var operationQueue = NSOperationQueue()
    
    var mainWindow: NSWindow!
    
    override init() {
        super.init()
        AppDelegate.operationQueue.maxConcurrentOperationCount = 1
    }
    
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        mainWindow = NSApplication.sharedApplication().windows[0] as! NSWindow
    }
    
    func applicationShouldHandleReopen(sender: NSApplication, hasVisibleWindows flag: Bool) -> Bool {
        
        if !flag {
            mainWindow.makeKeyAndOrderFront(nil)
        }
        
        return true
    }
}