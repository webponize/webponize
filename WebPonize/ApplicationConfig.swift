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
            return getIntValue(PreferenceKey.compressionLevel.rawValue)!
        }
        set {
            setValue(PreferenceKey.compressionLevel.rawValue, value: newValue)
        }
    }
    
    var isLossless: Bool {
        get {
            return getBoolValue(PreferenceKey.isLossless.rawValue)!
        }
        set {
            self.setValue(PreferenceKey.isLossless.rawValue, value: newValue)
        }
    }
    
    var isNoAlpha: Bool {
        get {
            return getBoolValue(PreferenceKey.isNoAlpha.rawValue)!
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
            setValue(PreferenceKey.isLossless.rawValue, value: true)
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
