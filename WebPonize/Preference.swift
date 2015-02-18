import Cocoa

class Preference: NSObject {
    
    let applicationId: CFString
    
    init(applicationId: String) {
        self.applicationId = applicationId as CFString
    }
    
    func setValue(key: String, value: AnyObject) {
        
        let key: CFString = key as CFString
        
        CFPreferencesSetAppValue(key, value, self.applicationId)
    }
    
    func getValue(key: String) -> CFPropertyList? {
        
        let key: CFString = key as CFString
        
        return CFPreferencesCopyAppValue(key, self.applicationId)
    }
}
