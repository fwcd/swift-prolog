import XCTest
import PrologSyntax
@testable import PrologInterpreter

final class UnificationTests: XCTestCase {
    static let allTests = [
        ("testUnification", testUnification)
    ]
    
    func testUnification() {
        XCTAssertEqual(
            unify("p(A)", "p(x)"),
            subst([("A", "x")])
        )
    }
    
    private func term(_ t: String) -> Term {
        return Term.parser.parseValue(from: t)!
    }
    
    private func subst(_ ms: [(String, String)]) -> Substitution {
        return Substitution(ms.map { ($0.0, term($0.1)) })
    }
    
    private func unify(_ t1: String, _ t2: String) -> Substitution? {
        return term(t1).unification(with: term(t2))
    }
}
