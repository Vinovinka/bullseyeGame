import XCTest

open class CustomUIElement {
    /// Underlying `XCUIElement`
    public let rootElement: XCUIElement

    // MARK: - Init

    required public init(_ element: XCUIElement = XCUIApplication()) {
        self.rootElement = element
    }
}

open class CustomUIElements<T: CustomUIElement> {
    public let query: XCUIElementQuery

    public init(_ query: XCUIElementQuery) {
        self.query = query
    }

    public func getElement(_ number: Int) -> T {
        let element = query.element(boundBy: number)
        element.waitForElement()

        return T(element)
    }
}
