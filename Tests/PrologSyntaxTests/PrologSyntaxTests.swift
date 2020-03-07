import XCTest
@testable import PrologSyntax

final class PrologSyntaxTests: XCTestCase {
    static var allTests = [
        ("termTermParser", testTermParser),
    ]

    func testTermParser() {
        XCTAssertEqual(
            Term.parser.parseValue(from: "A"),
            .variable("A")
        )
        XCTAssertEqual(
            Term.parser.parseValue(from: "demo"),
            .combinator("demo", [])
        )
        XCTAssertEqual(
            Term.parser.parseValue(from: "test()"),
            .combinator("test", [])
        )
        XCTAssertEqual(
            Term.parser.parseValue(from: "test(A, B)"),
            .combinator("test", [.variable("A"), .variable("B")])
        )
        XCTAssertEqual(
            Term.parser.parseValue(from: "add(s(X), Y, s(Z))"),
            .combinator("add", [
                .combinator("s", [.variable("X")]),
                .variable("Y"),
                .combinator("s", [.variable("Z")])
            ])
        )
    }
}
