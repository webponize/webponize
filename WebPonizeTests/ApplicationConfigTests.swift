import Cocoa
import XCTest

class ApplicationConfigTests: XCTestCase {
    var appConfig: ApplicationConfig
    
    override init() {
        appConfig = ApplicationConfig(applicationId: "test")
        super.init()
    }
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testQuality() {
        appConfig.quality = 80
        XCTAssertEqual(appConfig.quality, 80)

        appConfig.quality = 0
        XCTAssertEqual(appConfig.quality, 0)

        appConfig.quality = -10
        XCTAssertEqual(appConfig.quality, 0)
        
        appConfig.quality = 120
        XCTAssertEqual(appConfig.quality, 0)
    }
}
