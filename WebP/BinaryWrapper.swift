import Cocoa

class BinaryWrapper: NSObject {
    
    var binaryPath: String
    var currentDirectoryPath: String
    var arguments: [String]
    var fileHandle: NSFileHandle
    
    init(name: String, ofType: String) {

        // initialize bundle resource
        self.binaryPath = NSBundle.mainBundle().pathForResource(name, ofType: ofType)!
        
        // set directory path to execute
        self.currentDirectoryPath = ""

        // set arguments
        self.arguments = []
        self.fileHandle = NSFileHandle(forReadingAtPath: self.binaryPath)!
    }
    
    func setCurrentDirectoryPath(currentDirectoryPath: String) {
        self.currentDirectoryPath = currentDirectoryPath
    }
    
    func setArguments(arguments: Dictionary<String, String>) {
        self.arguments.removeAll(keepCapacity: false)
        for (key, value) in arguments {
            self.arguments.append("\(key)=\(arguments[key])")
        }
    }

    func setArguments(arguments: [String]) {
        self.arguments = arguments
    }

    func execute(arguments: Dictionary<String, String>) -> String {
        self.setArguments(arguments)
        return self.execute()
    }
    
    func execute(arguments: [String]) -> String {
        self.setArguments(arguments)
        return self.execute()
    }
    
    func execute() -> String {
        let task = NSTask()
        let pipe = NSPipe()

        task.launchPath = self.binaryPath
        task.currentDirectoryPath = self.currentDirectoryPath
        task.arguments = self.arguments
        task.standardOutput = pipe
        task.launch()
        
        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        return NSString(data: data, encoding: NSUTF8StringEncoding)!
    }
}

