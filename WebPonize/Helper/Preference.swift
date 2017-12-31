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
    
    func getString(_ key: String) -> String? {
        return get(key) as? String
    }
    
    func getInt(_ key: String) -> Int? {
        return get(key) as? Int
    }
    
    func getFloat(_ key: String) -> Float? {
        return get(key) as? Float
    }
    
    func getBool(_ key: String) -> Bool? {
        return get(key) as? Bool
    }
}
