import XCTest
@testable import PrologSyntax

final class PrologSyntaxTests: XCTestCase {
    static var allTests = [
        ("termTermParser", testTermParser),
    ]

    func testTermParser() {
        let term = Term.parser.parseValue(from: "test(A, B)")
        XCTAssertEqual(term, .combinator("test", [.variable("A"), .variable("B")]))
    }
}
