import XCTest

let app = XCUIApplication()

class BaseTestCase: XCTestCase {

    override func setUp() {
        self.continueAfterFailure = false
        super.setUp()
        launchApp()
    }

    func launchApp() {
        app.launch()
    }

    override func tearDown() {
        app.terminate()
        super.tearDown()
    }

}
