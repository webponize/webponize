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
    }
    
    func setDefaultValues() {

        if self.getValue(PreferenceKey.isInitialized.rawValue) != nil {
            return
        }
        
        self.setValue(PreferenceKey.isInitialized.rawValue, value: true)
        self.setValue(PreferenceKey.compressionLevel.rawValue, value: 80)
        self.setValue(PreferenceKey.isLossless.rawValue, value: false)
        self.setValue(PreferenceKey.isNoAlpha.rawValue, value: false)
    }
    
    func getCompressionLevel() -> Int {
        
        var rawValue: CFPropertyList?

        rawValue = self.getValue(PreferenceKey.compressionLevel.rawValue)
        
        return rawValue as Int
    }
    
    func setCompressionLevel(value: Int) {
        self.setValue(PreferenceKey.compressionLevel.rawValue, value: value)
    }
    
    func getIsLossless() -> Bool {
        
        var rawValue: CFPropertyList?
        
        rawValue = self.getValue(PreferenceKey.isLossless.rawValue)
        
        return rawValue as Bool
    }
    
    func setIsLossless(value: Bool) {
        self.setValue(PreferenceKey.isLossless.rawValue, value: value)
    }
    
    func getIsNoAlpha() -> Bool {
        
        var rawValue: CFPropertyList?
        
        rawValue = self.getValue(PreferenceKey.isNoAlpha.rawValue)
        
        return rawValue as Bool
    }
    
    func setIsNoAlpha(value: Bool) {
        self.setValue(PreferenceKey.isNoAlpha.rawValue, value: value)
    }
    
    func getValues() -> Dictionary<String, AnyObject> {
        var values = Dictionary<String, AnyObject>()

        values["compressionLevel"] = self.getCompressionLevel()
        values["isLossless"] = self.getIsLossless()
        values["isNoAlpha"] = self.getIsNoAlpha()
        
        return values
    }
}
