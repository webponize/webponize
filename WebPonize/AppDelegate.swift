import Cocoa
import Defaults

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    static var statusList: [Status] = []
    static var queue = OperationQueue()
    lazy var mainWindowController = MainWindowController()
    
    override init() {
        super.init()

        AppDelegate.queue.maxConcurrentOperationCount = 1
    }
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        mainWindowController.showWindow(self)
        mainWindowController.alignToCenter()
    }
        
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }
    
    func application(_ application: NSApplication, open urls: [URL]) {
        ConvertManager.openSavePanel(for: mainWindowController.window!, target: urls)
    }
}

extension Defaults.Keys {
    static let quality = Key<Float>("quality", default: 80)
    static let speed = Key<Int>("speed", default: 0)
    static let lossless = Key<Int>("lossless", default: 0)
}
