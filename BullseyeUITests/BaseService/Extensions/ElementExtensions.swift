import XCTest

public extension XCUIElement {

    enum PredicateFormat: String {
        case exists = "exists == 1"
        case notExists = "exists == 0"
        case isHittable = "isHittable == 1"
        case isEnabled = "isEnabled == 1"
        case isDisabled = "isEnabled == 0"
        case isSelected = "isSelected == 1"
        case hasFocus = "hasFocus == 1"
    }

    @discardableResult
    func waitForElement(_ predicateFormat: PredicateFormat = .exists, timeout: Double = Timeout.long, failOnError: Bool = false) -> Bool {

        let testcase = XCTestCase()

        let predicate = NSPredicate(format: predicateFormat.rawValue)

        let expecation = testcase.expectation(for: predicate, evaluatedWith: self, handler: nil)

        let result = XCTWaiter().wait(for: [expecation], timeout: timeout) == XCTWaiter.Result.completed

        if failOnError {
            XCTAssert(result, "Element \(self) is in the condition \(predicateFormat.rawValue)")
        }

        return result
    }

    func waitAndTap(predicateFormat: PredicateFormat = .exists, timeout: Double = Timeout.long) {
        self.waitForElement(predicateFormat, timeout: timeout )

        if self.isHittable {
            self.tap()
        } else {
            XCTFail("Failed to tap to element: \(self)")
        }
    }

    var stringValue: String {
        self.value as? String ?? ""
    }
}

public extension XCUIElementQuery {
    var lastMatch: XCUIElement {
        let lastMatchElement = self.element(boundBy: self.count - 1)
        return lastMatchElement
    }
}
