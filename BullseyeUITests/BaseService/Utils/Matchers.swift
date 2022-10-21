import XCTest

public func retryForResult(_ description: String,
                           retries: Int = 5,
                           retryTimeout: Double = 1.0,
                           action: () throws -> Void,
                           expectation: () -> Bool) {
    var result = false
    Report.step("\(description). \(retries > 1 ? "Попыток: \(retries). Интервал: \(retryTimeout)с" : "")") {
        for retry in 1 ... retries {
            do {
                try action()
            } catch {  }

            result = expectation()

            print(
                "Попытка \(retry) из \(retries): \(result ? "Success.\n": "Failure. Ожидаем \(retryTimeout) секунд.")"
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

    XCTAssertTrue(result, "Не смогли добиться условия: \(description)")
}

public func checkThat(_ description: String, retries: Int = 1, retryTimeout: Double = 0.5, closure:() -> Bool) {
    var result = false
    Report.check("\(description). \(retries > 1 ? "Попыток: \(retries). Интервал: \(retryTimeout)с" : "")") {
        for retry in 1 ... retries {
            result = closure()

            print(
                "Попытка \(retry) из \(retries): \(result ? "Success.\n" : "Failure. Ожидаем \(retryTimeout) секунд.")"
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

        XCTAssertTrue(result, "Проверка не пройдена: \(description)")
    }
}

public func checkTextExists(_ text: String) {
    Report.check("Отображение на экране текста '\(text)'") {
        XCTAssertTrue(app.staticTexts[text].waitForExistence(timeout: Timeout.double),
                      "Не удалось обнаружить текст на экране: '\(text)'")
    }
}

public func checkElementExists(_ element: XCUIElement, timeout: Double = Timeout.double) {
    Report.check("Отображение элемента '\(element)'") {
        XCTAssertTrue(element.waitForExistence(timeout: timeout),
                      "Не дождались отображения элемента: \(element)")
    }
}

public func checkElementNotExists(_ element: XCUIElement, timeout: Double = Timeout.medium) {
    Report.check("Отсутствие элемента '\(element)'") {
        XCTAssertTrue(element.waitForElement(.notExists, timeout: timeout),
                      "Не дождались отсутствия элемента: \(element)")
    }
}

// Полное совпадение текста: текст на вьюхе в точности равен искомому
public func checkElementHasText(_ element: XCUIElement, _ text: String) {
    Report.check("Текст внутри элемента '\(element)' совпадает с текстом '\(text)'") {
        XCTAssertTrue(element.label == text || element.stringValue == text, "Не удалось найти текст " +
                        "'\(text)' внутри элемента \(element). " +
                        "Актуальный текст: \(element.stringValue) \(element.label)"
        )
    }
}

// Частичное совпадение текста: текст на вьюхе содержит в себе искомый
public func checkElementContainsText(_ element: XCUIElement, _ text: String) {
    Report.check("Элемент '\(element)' содержит текст '\(text)'") {
        XCTAssertTrue(element.label.contains(text) || element.stringValue.contains(text), "Не удалось найти текст" +
                        " '\(text)' внутри элемента \(element). " +
                        "Актуальный текст: \(element.stringValue) \(element.label)"
        )
    }
}

public func checkElementValueText(_ element: XCUIElement, _ text: String) {
        XCTAssertTrue(element.stringValue == text,
                      "Value элемента \(element) не совпало с ожидаемым. Актуальное Value: \(element.stringValue)")
}

public func checkTextNotNil(_ element: XCUIElement) {
    Report.check("Текст элемента '\(element)' не пуст") {
        XCTAssertFalse(element.label.isEmpty,
                       "Текст элемента \(element) пуст")
    }
}

public func checkTextIsEmpty(_ element: XCUIElement) {
    Report.check("Текст элемента '\(element)' пуст") {
        XCTAssertTrue(element.label.isEmpty && element.stringValue.isEmpty,
                      "Текст элемента \(element) не пуст. Актуальный текст: \(element.stringValue) \(element.label)")
    }
}
