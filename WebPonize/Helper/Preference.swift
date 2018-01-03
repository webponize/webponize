import Cocoa

class Preference: NSObject {
    var applicationId: CFString

    init(applicationId: String) {
        self.applicationId = applicationId as CFString
    }
    
    func set(_ key: String, value: AnyObject) {
        CFPreferencesSetAppValue(key as CFString, value, applicationId)
    }
    
    func get(_ key: String) -> CFPropertyList? {
        return CFPreferencesCopyAppValue(key as CFString, applicationId)
    }
    
    func has(_ key: String) -> Bool {
        return CFPreferencesCopyAppValue(key as CFString, applicationId) != nil
    }
}
