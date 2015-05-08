import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    var config: ApplicationConfig = ApplicationConfig()
    
    class func getAppDelegate() -> AppDelegate {
        return NSApplication.sharedApplication().delegate! as AppDelegate
    }
}