import XCTest
@testable import PrologInterpreter

final class PrologTests: XCTestCase {
    static var allTests = [
        ("testExample", testExample),
    ]

    private func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(PrologInterpreter().text, "Hello, World!")
    }
}
