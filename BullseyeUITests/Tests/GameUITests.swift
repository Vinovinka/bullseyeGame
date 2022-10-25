import XCTest

class GameUITests: BaseTestCase {

    let mainGamePage = MainGamePage()
    let gameSteps = GameSteps()
    let leaderboardPage = LeaderboardPage()

    func testHitMeButton() {

        Report.step("Start new game") {
            gameSteps.newGame()
        }

        Report.step("Check your points") {
            checkElementContainsText(mainGamePage.yourScoreLabel, "You scored ")
        }

        Report.step("Tap to Start new round button") {
            mainGamePage.startNewRowndButton.tap()
        }

        Report.step("Check that new round value is 2") {
            checkElementContainsText(mainGamePage.roundLabel, "ROUND, 2")
        }
    }

    func testEmptyLeaderboard() {

        Report.step("Checking the Leaderboard button") {
            checkElementExists(mainGamePage.leaderboardButton)
        }

        Report.step("Go to Leaderboard") {
            mainGamePage.leaderboardButton.tap()
        }

        Report.step("Checking the Leaderboard close button") {
            checkElementExists(leaderboardPage.closeButton)
        }
    }
}
