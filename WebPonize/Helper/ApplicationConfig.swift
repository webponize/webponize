import Cocoa

class ApplicationConfig: Preference {
    enum PreferenceKey: String {
        case isInitialized = "isInitialized"
        case compressionLevel = "compressionLevel"
        case lossless = "lossless"
    }
    
    var compressionLevel: Float {
        get {
            return getFloatValue(PreferenceKey.compressionLevel.rawValue)!
        }

        set {
            setValue(PreferenceKey.compressionLevel.rawValue, value: newValue as AnyObject)
        }
    }
    
    var lossless: Int {
        get {
            return getIntValue(PreferenceKey.lossless.rawValue)!
        }

        set {
            setValue(PreferenceKey.lossless.rawValue, value: newValue as AnyObject)
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
            setValue(PreferenceKey.lossless.rawValue, value: 0 as AnyObject)
        }
    }

    func getValues() -> Dictionary<String, AnyObject> {
        var values = Dictionary<String, AnyObject>()
        values[PreferenceKey.compressionLevel.rawValue] = compressionLevel as AnyObject?
        values[PreferenceKey.lossless.rawValue] = lossless as AnyObject?
        return values
    }
}
