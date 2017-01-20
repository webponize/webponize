import Cocoa

class gif2webp: NSObject {
    
    var binaryPath: String
    var currentDirectoryPath: String
    var arguments: [String]
    
    override init() {
        let bundle = Bundle.main
        binaryPath = bundle.path(forResource: "gif2webp", ofType: "")!
        currentDirectoryPath = ""
        arguments = []
    }
    
    func execute(_ arguments: Dictionary<String, String>) -> String {
        self.arguments.removeAll(keepingCapacity: false)
        for (key, _) in arguments {
            self.arguments.append("\(key)=\(arguments[key])")
        }
        return self.execute()
    }
    
    func execute() -> String {
        let task = Process()
        let pipe = Pipe()
        
        task.launchPath = binaryPath
        task.currentDirectoryPath = currentDirectoryPath
        task.arguments = arguments
        task.standardOutput = pipe
        task.launch()
        
        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        return NSString(data: data, encoding: String.Encoding.utf8.rawValue)! as String
    }
}
