import Cocoa

class BinaryWrapper: NSObject {
    
    var binaryPath: String
    var fileHandle: NSFileHandle
    
    init(name: String, ofType: String) {
        let bundle = NSBundle.mainBundle()
        self.binaryPath = bundle.pathForResource(name, ofType: ofType)!
        self.fileHandle = NSFileHandle(forReadingAtPath: self.binaryPath)!
    }
    
    func execute(arguments: Dictionary<String, String>) -> String {

        var flatten: [String] = []
        
        for (key, value) in arguments {
            flatten.append("\(key)=\(arguments[key])")
        }
        
        return self.execute(arguments: flatten)
    }
    
    func execute(#arguments: [String]) -> String {

        let task = NSTask()
        let pipe = NSPipe()

        task.launchPath = self.binaryPath
        task.arguments = arguments
        task.standardOutput = pipe
        task.launch()
        
        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        return NSString(data: data, encoding: NSUTF8StringEncoding)!
    }
}

