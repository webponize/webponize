import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    static var appConfig = ApplicationConfig()

    static var fileStatusList: [FileStatus] = []
    
    static var operationQueue = NSOperationQueue()
    
    override init() {
        super.init()
        AppDelegate.operationQueue.maxConcurrentOperationCount = 1
    }
}