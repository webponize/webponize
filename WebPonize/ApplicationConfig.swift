import Cocoa

class ApplicationConfig: Preference {

    enum PreferenceKey: String {
        case isInitialized = "isInitialized"
        case compressionLevel = "compressionLevel"
        case isLossless = "isLossless"
        case isNoAlpha = "isNoAlpha"
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
    
    func getCompressionLevel() -> Int {
        var value: CFPropertyList? = getValue(PreferenceKey.compressionLevel.rawValue)
        return value as! Int
    }
    
    func setCompressionLevel(value: Int) {
        setValue(PreferenceKey.compressionLevel.rawValue, value: value)
    }
    
    func getIsLossless() -> Bool {
        var value: CFPropertyList? = getValue(PreferenceKey.isLossless.rawValue)
        return value as! Bool
    }
    
    func setIsLossless(value: Bool) {
        self.setValue(PreferenceKey.isLossless.rawValue, value: value)
    }
    
    func getIsNoAlpha() -> Bool {
        var value: CFPropertyList? = getValue(PreferenceKey.isNoAlpha.rawValue)
        return value as! Bool
    }
    
    func setIsNoAlpha(value: Bool) {
        setValue(PreferenceKey.isNoAlpha.rawValue, value: value)
    }
    
    func getValues() -> Dictionary<String, AnyObject> {
        var values = Dictionary<String, AnyObject>()
        values["compressionLevel"] = getCompressionLevel()
        values["isLossless"] = getIsLossless()
        values["isNoAlpha"] = getIsNoAlpha()
        return values
    }
}
