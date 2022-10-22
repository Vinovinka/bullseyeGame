import XCTest

public class Report {
    public static var nextId = 1
    public static var currentStepId = 0

    public static func preparation(_ description: String, stepBody: () -> Void) {
        let name = "Подготовка: \(description)"
        wrapActivity(activityName: name) { stepBody() }
    }

    public static func tearDown(_ description: String, stepBody: () -> Void) {
        let name = "Завершение: \(description)"
        wrapActivity(activityName: name) { stepBody() }
    }

    public static func step(_ description: String, stepBody: () -> Void) {
        let name = "Шаг: \(description)"
        wrapActivity(activityName: name) { stepBody() }
    }


    public static func check(_ description: String, stepBody: () -> Void) {
        let name = "Проверка: \(description)"
        wrapActivity(activityName: name) { stepBody() }
    }

    public static func wrapActivity<T: Any>(activityName: String, stepBody: () throws -> T) rethrows -> T {
        let id = nextId
        nextId += 1
        let parentId = currentStepId
        currentStepId = id

        @Lateinit var result: T
        print("Starting step \(id)")

        do {
            try XCTContext.runActivity(named: activityName) { _ in
                result = try stepBody()
            }
            currentStepId = parentId
        } catch {
            currentStepId = parentId
            throw error
        }
        return result
    }
}

@propertyWrapper
public struct Lateinit<T> {
    var propertyValue: T?

    public var wrappedValue: T {
    get {
      guard let value = propertyValue else {
        fatalError("Property being accessed without initialization")
      }
      return value
    }
    set {
      guard propertyValue == nil else {
        fatalError("Property already initialized")
      }
        propertyValue = newValue
        }
    }

    public init() {}
}

