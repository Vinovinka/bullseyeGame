import XCTest

class MainGamePage: CustomUIElement {
    convenience init() {
        self.init(app.otherElements["backgroundView"])
    }

    lazy var hitMeButton = rootElement.buttons["hitMeButton"]
    lazy var slider = rootElement.sliders["slider"]
    lazy var requestedSliderValue = rootElement.staticTexts["requestedNumberValue"]
    lazy var yourScoreLabel = rootElement.staticTexts["yourScoreLabel"]
}
