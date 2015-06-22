import Cocoa

class gif2webp: NSObject {
    
    var binaryPath: String
    var currentDirectoryPath: String
    var arguments: [String]
    
    override init() {
        let bundle = NSBundle.mainBundle()
        binaryPath = bundle.pathForResource("gif2webp", ofType: "")!
        currentDirectoryPath = ""
        arguments = []
    }
    
    func execute(arguments: Dictionary<String, String>) -> String {
        self.arguments.removeAll(keepCapacity: false)
        for (key, value) in arguments {
            self.arguments.append("\(key)=\(arguments[key])")
        }
        return self.execute()
    }
    
    func execute() -> String {
        let task = NSTask()
        let pipe = NSPipe()
        
        task.launchPath = binaryPath
        task.currentDirectoryPath = currentDirectoryPath
        task.arguments = arguments
        task.standardOutput = pipe
        task.launch()
        
        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        return NSString(data: data, encoding: NSUTF8StringEncoding)! as String
    }
}