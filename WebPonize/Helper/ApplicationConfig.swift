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
            setValue(PreferenceKey.compressionLevel.rawValue, value: newValue as AnyObject)
        }
    }
    
    var isLossless: Bool {
        get {
            return getBoolValue(PreferenceKey.isLossless.rawValue)!
        }

        set {
            self.setValue(PreferenceKey.isLossless.rawValue, value: newValue as AnyObject)
        }
    }
    
    var isNoAlpha: Bool {
        get {
            return getBoolValue(PreferenceKey.isNoAlpha.rawValue)!
        }

        set {
            setValue(PreferenceKey.isNoAlpha.rawValue, value: newValue as AnyObject)
        }
    }

    init() {
        super.init(applicationId: "net.1000ch.WebPonize")
        setDefaultValues()
    }
    
    func setDefaultValues() {
        if getValue(PreferenceKey.isInitialized.rawValue) == nil {
            setValue(PreferenceKey.isInitialized.rawValue, value: true as AnyObject)
            setValue(PreferenceKey.compressionLevel.rawValue, value: 80 as AnyObject)
            setValue(PreferenceKey.isLossless.rawValue, value: true as AnyObject)
            setValue(PreferenceKey.isNoAlpha.rawValue, value: false as AnyObject)
        }
    }

    func getValues() -> Dictionary<String, AnyObject> {
        var values = Dictionary<String, AnyObject>()
        values[PreferenceKey.compressionLevel.rawValue] = compressionLevel as AnyObject?
        values[PreferenceKey.isLossless.rawValue] = isLossless as AnyObject?
        values[PreferenceKey.isNoAlpha.rawValue] = isNoAlpha as AnyObject?
        return values
    }
}
