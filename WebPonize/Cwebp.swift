import Cocoa

class Cwebp: BinaryWrapper {
    init() {
        super.init(pathForResource: "cwebp", ofType: "", inDirectory: "lib")
    }
}
