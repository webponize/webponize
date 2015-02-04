import Cocoa

class Compress2Webp: BinaryWrapper {
    init() {
        super.init(pathForResource: "cwebp", ofType: "", inDirectory: "lib")
    }
}
