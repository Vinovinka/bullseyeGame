import XCTest

final class BullseyeUITests: BaseTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    func testLaunchApp() {
        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
