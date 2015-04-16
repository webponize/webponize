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
        self.setDefaultValues()
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

    // Returns the saved output-directory to save the files to.
    // If one has not been saved, it prompts the user, and saves the result.
    //
    // :param: window The NSWindow to display the prompt from
    // :completion: The block to be run with the user-selected directory. 
    //              :param: String The path selected by the user
    //              :param: Void -> Void Completion block -- must be called when you are done using the path
    func getOutputDirectory(window: NSWindow, completion: ((String, (Void -> Void)) -> Void)) {
        let defaults = NSUserDefaults.standardUserDefaults()
        
        if let bookmark = NSUserDefaults.standardUserDefaults().dataForKey("BookmarkData") {
            var error: NSError?
            
            if let url = NSURL(byResolvingBookmarkData: bookmark, options: NSURLBookmarkResolutionOptions.WithSecurityScope, relativeToURL: nil, bookmarkDataIsStale: nil, error: &error) {
                if let error = error {
                    NSLog("Error resovling bookmark: \(error)")
                }
                
                url.startAccessingSecurityScopedResource()
                completion(url.absoluteString!) {
                    url.stopAccessingSecurityScopedResource()
                }
                
            }
        } else {
            let panel = NSOpenPanel()
            panel.canCreateDirectories = true
            panel.canChooseDirectories = true
            panel.canChooseFiles = false
            panel.allowsMultipleSelection = false
            panel.beginSheetModalForWindow(window) { [weak panel, weak self] (result: Int) -> Void in
                var error: NSError?
                if result == NSModalResponseOK {
                    
                    if let outputURL = panel?.URL {

                        
                        if let bookmark = outputURL.bookmarkDataWithOptions(NSURLBookmarkCreationOptions.WithSecurityScope, includingResourceValuesForKeys: nil, relativeToURL: nil, error: &error) {
                            if let error = error {
                                NSLog("Error opening bookmark: \(error)")
                            }
                            error = nil
                            
                            if let url = NSURL(byResolvingBookmarkData: bookmark, options: NSURLBookmarkResolutionOptions.WithSecurityScope, relativeToURL: nil, bookmarkDataIsStale: nil, error: &error) {
                                if let error = error {
                                    NSLog("Error resovling bookmark: \(error)")
                                }
                                
                                defaults.setObject(bookmark, forKey: "BookmarkData")
                                defaults.synchronize()
                                
                                url.startAccessingSecurityScopedResource()
                                completion(url.absoluteString!) {
                                    url.stopAccessingSecurityScopedResource()
                                }
                                
                            }

                        }
                    }
                }
            }

        }
        
    }

}
