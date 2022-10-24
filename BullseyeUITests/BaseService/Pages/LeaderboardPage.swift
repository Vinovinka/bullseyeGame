import XCTest

class LeaderboardPage: CustomUIElement {
    convenience init() {
        self.init(app.otherElements["leaderboardView"])
    }

    lazy var closeButton = rootElement.buttons["closeButton"]
}
