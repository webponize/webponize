import Cocoa

class Preference: NSObject {
    
    let applicationId: CFString
    
    init(applicationId: String) {
        self.applicationId = applicationId as CFString
    }
    
    func setValue(key: String, value: AnyObject) {
        CFPreferencesSetAppValue(key as CFString, value, applicationId)
    }
    
    func getValue(key: String) -> CFPropertyList? {
        return CFPreferencesCopyAppValue(key as CFString, applicationId)
    }
}
