import Cocoa

class ApplicationConfig: Preference {

    enum PreferenceKey: String {
        case isInitialized = "isInitialized"
        case compressionLevel = "compressionLevel"
        case isLossless = "isLossless"
        case isNoAlpha = "isNoAlpha"
    }
    
    var compressionLevel: Int {
        get {
            var value: CFPropertyList? = getValue(PreferenceKey.compressionLevel.rawValue)
            return value as! Int
        }
        set {
            setValue(PreferenceKey.compressionLevel.rawValue, value: newValue)
        }
    }
    
    var isLossless: Bool {
        get {
            var value: CFPropertyList? = getValue(PreferenceKey.isLossless.rawValue)
            return value as! Bool
        }
        set {
            self.setValue(PreferenceKey.isLossless.rawValue, value: newValue)
        }
    }
    
    var isNoAlpha: Bool {
        get {
            var value: CFPropertyList? = getValue(PreferenceKey.isNoAlpha.rawValue)
            return value as! Bool
        }
        set {
            setValue(PreferenceKey.isNoAlpha.rawValue, value: newValue)
        }
    }

    init() {
        super.init(applicationId: "net.1000ch.WebPonize")
        setDefaultValues()
    }
    
    func setDefaultValues() {
        if getValue(PreferenceKey.isInitialized.rawValue) == nil {
            setValue(PreferenceKey.isInitialized.rawValue, value: true)
            setValue(PreferenceKey.compressionLevel.rawValue, value: 80)
            setValue(PreferenceKey.isLossless.rawValue, value: false)
            setValue(PreferenceKey.isNoAlpha.rawValue, value: false)
        }
    }

    func getValues() -> Dictionary<String, AnyObject> {
        var values = Dictionary<String, AnyObject>()
        values["compressionLevel"] = compressionLevel
        values["isLossless"] = isLossless
        values["isNoAlpha"] = isNoAlpha
        return values
    }
}
