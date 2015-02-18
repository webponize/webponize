import Cocoa

class ApplicationConfig: Preference {

    enum PreferenceKey: String {
        case isInitialized = "isInitialized"
        case compressionLevel = "compressionLevel"
        case isLossless = "isLossless"
        case isNoAlpha = "isNoAlpha"
    }

    init() {
        super.init(applicationId: "net.1000ch.WebP")
    }
    
    func setDefaultValues() {
        if self.getValue(PreferenceKey.isInitialized.rawValue) == nil {
            
            self.setValue(PreferenceKey.isInitialized.rawValue, value: true)
            
            self.setValue(PreferenceKey.compressionLevel.rawValue, value: 80)
            self.setValue(PreferenceKey.isLossless.rawValue, value: false)
            self.setValue(PreferenceKey.isNoAlpha.rawValue, value: false)
        }
    }
    
    func getCompressionLevel() -> Int {
        return self.getValue(PreferenceKey.compressionLevel.rawValue) as Int
    }
    
    func setCompressionLevel(value: Int) {
        self.setValue(PreferenceKey.compressionLevel.rawValue, value: value)
    }
    
    func getIsLossless() -> Bool {
        return self.getValue(PreferenceKey.isLossless.rawValue) as Bool
    }
    
    func setIsLossless(value: Bool) {
        self.setValue(PreferenceKey.isLossless.rawValue, value: value)
    }
    
    func getIsNoAlpha() -> Bool {
        return self.getValue(PreferenceKey.isNoAlpha.rawValue) as Bool
    }
    
    func setIsNoAlpha(value: Bool) {
        self.setValue(PreferenceKey.isNoAlpha.rawValue, value: value)
    }
    
    func getValues() -> Dictionary<String, AnyObject> {
        var values: Dictionary<String, AnyObject> = Dictionary<String, AnyObject>()

        values["compressionLevel"] = self.getCompressionLevel()
        values["isLossless"] = self.getIsLossless()
        values["isNoAlpha"] = self.getIsNoAlpha()
        
        return values
    }
}
