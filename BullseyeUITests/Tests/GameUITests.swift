import XCTest

class GameUITests: BaseTestCase {

    let mainGamePage = MainGamePage()
    let gameSteps = GameSteps()

    func testHitMeButton() {

        gameSteps.newGame()
        
        Report.step("Check your points") {
            checkElementContainsText(mainGamePage.yourScoreLabel, "You scored 14")
        }
    }
}
