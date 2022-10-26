import XCTest

class GameSteps {
    var testcase: BaseTestCase { BaseTestCase() }

    let mainGamePage = MainGamePage()

    func newGame() {
        let requestedValue = Float(mainGamePage.requestedSliderValue.label) ?? 1

        let numberBetween01 = CGFloat((requestedValue - 1.0) / 99.0)

        mainGamePage.slider.adjust(toNormalizedSliderPosition: numberBetween01)

        mainGamePage.hitMeButton.tap()
    }

    func openLeaderboard() {
        mainGamePage.leaderboardButton.tap()
    }
}
