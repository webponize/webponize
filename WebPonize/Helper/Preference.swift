import Cocoa

class Preference: NSObject {
    var applicationId: CFString

    init(applicationId: String) {
        self.applicationId = applicationId as CFString
    }
    
    func setValue(_ key: String, value: AnyObject) {
        let key = key as CFString

        CFPreferencesSetAppValue(key, value, applicationId)
    }
    
    func getValue(_ key: String) -> CFPropertyList? {
        let key = key as CFString

        return CFPreferencesCopyAppValue(key, applicationId)
    }
    
    func getStringValue(_ key: String) -> String? {
        return getValue(key) as? String
    }
    
    func getIntValue(_ key: String) -> Int? {
        return getValue(key) as? Int
    }
    
    func getBoolValue(_ key: String) -> Bool? {
        return getValue(key) as? Bool
    }
}
