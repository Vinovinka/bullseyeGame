import XCTest

public func retryForResult(_ description: String,
                           retries: Int = 5,
                           retryTimeout: Double = 1.0,
                           action: () throws -> Void,
                           expectation: () -> Bool) {
    var result = false
    Report.step("\(description). \(retries > 1 ? "Try: \(retries). Interval: \(retryTimeout) s" : "")") {
        for retry in 1 ... retries {
            do {
                try action()
            } catch {  }

            result = expectation()

            print(
                "Try \(retry) from \(retries): \(result ? "Success.\n": "Failure. Waiting for \(retryTimeout) seconds.")"
            )
            if result { break }

            if retry < retries {
                let group = DispatchGroup()

                group.enter()
                DispatchQueue.global(qos: .default).asyncAfter(deadline: .now() + retryTimeout) {
                    group.leave()
                }
                group.wait()
            }
        }
    }

    XCTAssertTrue(result, "Failed to meet condition: \(description)")
}

public func checkThat(_ description: String, retries: Int = 1, retryTimeout: Double = 0.5, closure:() -> Bool) {
    var result = false
    Report.check("\(description). \(retries > 1 ? "Try: \(retries). Interval: \(retryTimeout) s" : "")") {
        for retry in 1 ... retries {
            result = closure()

            print(
                "Try \(retry) from \(retries): \(result ? "Success.\n" : "Failure. Waiting for \(retryTimeout) second.")"
            )
            if result { break }

            if retry < retries {
                let group = DispatchGroup()

                group.enter()
                DispatchQueue.global(qos: .default).asyncAfter(deadline: .now() + retryTimeout) {
                    group.leave()
                }
                group.wait()
            }
        }

        XCTAssertTrue(result, "Check failed: \(description)")
    }
}

public func checkTextExists(_ text: String) {
    Report.check("Displaying text on the screen '\(text)'") {
        XCTAssertTrue(app.staticTexts[text].waitForExistence(timeout: Timeout.double),
                      "Unable to detect text on screen: '\(text)'")
    }
}

public func checkElementExists(_ element: XCUIElement, timeout: Double = Timeout.double) {
    Report.check("Displaying of element '\(element)'") {
        XCTAssertTrue(element.waitForExistence(timeout: timeout),
                      "Unable to detect element on screen: \(element)")
    }
}

public func checkElementNotExists(_ element: XCUIElement, timeout: Double = Timeout.medium) {
    Report.check("Absence of element '\(element)'") {
        XCTAssertTrue(element.waitForElement(.notExists, timeout: timeout),
                      "Не дождались отсутствия элемента: \(element)")
    }
}

public func checkElementHasText(_ element: XCUIElement, _ text: String) {
    Report.check("Text inside the element '\(element)' is '\(text)'") {
        XCTAssertTrue(element.label == text || element.stringValue == text, "Failed to detect text " +
                        "'\(text)' inside the element \(element). " +
                        "Actual text is: \(element.stringValue) \(element.label)"
        )
    }
}

// Частичное совпадение текста: текст на вьюхе содержит в себе искомый
public func checkElementContainsText(_ element: XCUIElement, _ text: String) {
    Report.check("Element '\(element)' contains text '\(text)'") {
        XCTAssertTrue(element.label.contains(text) || element.stringValue.contains(text), "Failed to detect text" +
                        " '\(text)' inside the element \(element). " +
                        "Actual text is: \(element.stringValue) \(element.label)"
        )
    }
}

public func checkElementValueText(_ element: XCUIElement, _ text: String) {
        XCTAssertTrue(element.stringValue == text,
                      "Value of element \(element) isn't match expected. Actual value is: \(element.stringValue)")
}

public func checkTextNotNil(_ element: XCUIElement) {
    Report.check("Text of element '\(element)' is not empty") {
        XCTAssertFalse(element.label.isEmpty,
                       "Text of element \(element) is empty")
    }
}

public func checkTextIsEmpty(_ element: XCUIElement) {
    Report.check("Text of element '\(element)' is empty") {
        XCTAssertTrue(element.label.isEmpty && element.stringValue.isEmpty,
                      "Text of element \(element) isn't empty. Actual text is: \(element.stringValue) \(element.label)")
    }
}
