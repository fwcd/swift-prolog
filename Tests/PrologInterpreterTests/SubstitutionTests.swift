import XCTest
@testable import PrologInterpreter

final class SubstitutionTests: XCTestCase {
    static var allTests = [
        ("testSubstitution", testSubstitution),
        ("testComposition", testComposition)
    ]
    
    func testSubstitution() {
        let s1 = Substitution([
            ("A", .combinator("s", [.variable("B")])),
            ("C", .combinator("a", []))
        ])
        XCTAssertEqual(
            s1.applied(to: .combinator("s", [.variable("A"), .variable("C")])),
            .combinator("s", [.combinator("s", [.variable("B")]), .combinator("a", [])])
        )
        
        let s2 = Substitution([
            ("A", .variable("B")),
            ("A", .variable("C")),
            ("B", .variable("D"))
        ])
        XCTAssertEqual(
            s2.applied(to: .combinator(".", [.variable("A"), .variable("A")])),
            .combinator(".", [.variable("D"), .variable("D")])
        )
        
        let s3 = Substitution([
            ("A", .variable("B")),
            ("C", .combinator("d", [.variable("A")]))
        ])
        XCTAssertEqual(s3.pretty, "{A -> B, C -> d(A)}")
    }
    
    func testComposition() {
        
    }
}
