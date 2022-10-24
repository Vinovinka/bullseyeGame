import XCTest

class GameUITests: BaseTestCase {

    let mainGamePage = MainGamePage()
    let gameSteps = GameSteps()
    let leaderboardPage = LeaderboardPage()

    func testHitMeButton() {

        gameSteps.newGame()
        
        Report.step("Check your points") {
            checkElementContainsText(mainGamePage.yourScoreLabel, "You scored 14")
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
