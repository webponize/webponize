import Cocoa

class ApplicationConfig: Preference {
    enum PreferenceKey: String {
        case initialized = "initialized"
        case quality = "quality"
        case speed = "speed"
        case lossless = "lossless"
        case filterStrength = "filterStrength"
        case filterSharpness = "filterSharpness"
        case filterType = "filterType"
        case autoFilter = "autoFilter"
        case alphaQuality = "alphaQuality"
        case alphaFiltering = "alphaFiltering"
        case alphaCompression = "alphaCompression"
    }
    
    var quality: Float {
        get {
            return getFloat(PreferenceKey.quality.rawValue)!
        }

        set {
            set(PreferenceKey.quality.rawValue, value: newValue as AnyObject)
        }
    }
    
    var speed: Int {
        get {
            return getInt(PreferenceKey.speed.rawValue)!
        }
        
        set {
            set(PreferenceKey.speed.rawValue, value: newValue as AnyObject)
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
    
    var filterStrength: Int {
        get {
            return getInt(PreferenceKey.filterStrength.rawValue)!
        }
        
        set {
            set(PreferenceKey.filterStrength.rawValue, value: newValue as AnyObject)
        }
    }
    
    var filterSharpness: Int {
        get {
            return getInt(PreferenceKey.filterSharpness.rawValue)!
        }
        
        set {
            set(PreferenceKey.filterSharpness.rawValue, value: newValue as AnyObject)
        }
    }
    
    var filterType: Int {
        get {
            return getInt(PreferenceKey.filterType.rawValue)!
        }
        
        set {
            set(PreferenceKey.filterType.rawValue, value: newValue as AnyObject)
        }
    }
    
    var autoFilter: Int {
        get {
            return getInt(PreferenceKey.autoFilter.rawValue)!
        }
        
        set {
            set(PreferenceKey.autoFilter.rawValue, value: newValue as AnyObject)
        }
    }
    
    var alphaQuality: Int {
        get {
            return getInt(PreferenceKey.alphaQuality.rawValue)!
        }
        
        set {
            set(PreferenceKey.alphaQuality.rawValue, value: newValue as AnyObject)
        }
    }
    
    var alphaFiltering: Int {
        get {
            return getInt(PreferenceKey.alphaFiltering.rawValue)!
        }
        
        set {
            set(PreferenceKey.alphaFiltering.rawValue, value: newValue as AnyObject)
        }
    }
    
    var alphaCompression: Int {
        get {
            return getInt(PreferenceKey.alphaCompression.rawValue)!
        }
        
        set {
            set(PreferenceKey.alphaCompression.rawValue, value: newValue as AnyObject)
        }
    }
    
    init() {
        super.init(applicationId: "net.1000ch.WebPonize")

        if get(PreferenceKey.initialized.rawValue) == nil {
            set(PreferenceKey.initialized.rawValue, value: true as AnyObject)
            set(PreferenceKey.quality.rawValue, value: 80 as AnyObject)
            set(PreferenceKey.speed.rawValue, value: 0 as AnyObject)
            set(PreferenceKey.lossless.rawValue, value: 0 as AnyObject)
            set(PreferenceKey.filterStrength.rawValue, value: 0 as AnyObject)
            set(PreferenceKey.filterSharpness.rawValue, value: 0 as AnyObject)
            set(PreferenceKey.filterType.rawValue, value: 0 as AnyObject)
            set(PreferenceKey.autoFilter.rawValue, value: 0 as AnyObject)
            set(PreferenceKey.alphaQuality.rawValue, value: 100 as AnyObject)
            set(PreferenceKey.alphaFiltering.rawValue, value: 1 as AnyObject)
            set(PreferenceKey.alphaCompression.rawValue, value: 1 as AnyObject)
        }
    }
}
