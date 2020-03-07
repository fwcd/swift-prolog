import XCTest
@testable import PrologSyntax

final class PrologSyntaxTests: XCTestCase {
    static let allTests = [
        ("testTermParser", testTermParser),
        ("testTermSubstitutions", testTermSubstitutions),
        ("testGoalParser", testGoalParser)
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
    
    func testTermSubstitutions() {
        XCTAssertEqual(
            Term.variable("D").substituting("C", with: .variable("S")),
            Term.variable("D")
        )
        XCTAssertEqual(
            Term.combinator("d", [.variable("B")]).substituting("D", with: .variable("A")),
            Term.combinator("d", [.variable("B")])
        )
        XCTAssertEqual(
            Term.combinator("d", [.variable("B"), .variable("B")]).substituting("B", with: .combinator("s", [.variable("A")])),
            Term.combinator("d", [.combinator("s", [.variable("A")]), .combinator("s", [.variable("A")])])
        )
        XCTAssertEqual(
            (Term.parser.parseValue(from: "add(A, B)")?.substituting("A", with: .variable("C"))).map { "\($0)" },
            "add(C, B)"
        )
    }
    
    func testGoalParser() {
        XCTAssertEqual(
            Goal.parser.parseValue(from: "."),
            Goal(terms: [])
        )
        XCTAssertEqual(
            Goal.parser.parseValue(from: "test(A, B)."),
            Goal(terms: [
                .combinator("test", [
                    .variable("A"),
                    .variable("B")
                ])
            ])
        )
        XCTAssertEqual(
            Goal.parser.parseValue(from: "A, demo."),
            Goal(terms: [
                .variable("A"),
                .combinator("demo", [])
            ])
        )
    }
}
