import Cocoa

class ApplicationConfig: Preference {
    enum PreferenceKey: String {
        case isInitialized = "isInitialized"
        case compressionLevel = "compressionLevel"
        case lossless = "lossless"
    }
    
    var compressionLevel: Float {
        get {
            return getFloat(PreferenceKey.compressionLevel.rawValue)!
        }

        set {
            set(PreferenceKey.compressionLevel.rawValue, value: newValue as AnyObject)
        }
    }
    
    var lossless: Int {
        get {
            return getInt(PreferenceKey.lossless.rawValue)!
        }

        set {
            set(PreferenceKey.lossless.rawValue, value: newValue as AnyObject)
        }
    }
    
    init() {
        super.init(applicationId: "net.1000ch.WebPonize")

        if get(PreferenceKey.isInitialized.rawValue) == nil {
            set(PreferenceKey.isInitialized.rawValue, value: true as AnyObject)
            set(PreferenceKey.compressionLevel.rawValue, value: 80 as AnyObject)
            set(PreferenceKey.lossless.rawValue, value: 0 as AnyObject)
        }
    }
}
