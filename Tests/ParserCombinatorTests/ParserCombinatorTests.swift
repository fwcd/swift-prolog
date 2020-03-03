import XCTest
@testable import ParserCombinators

final class ParserCombinatorTests: XCTestCase {
    static var allTests = [
        ("testConst", testConst),
        ("testAlt", testAlt),
        ("testOpt", testOpt),
        ("testRep", testRep),
        ("testRep1", testRep1),
        ("testRecursion", testRecursion)
    ]
    
    func testConst() {
        let (l, s) = const("T").parse(from: "Test")!
        XCTAssertEqual(l, "T")
        XCTAssertEqual(s, "est")
        XCTAssertNil(const("Demo").parse(from: "abc"))
    }

    func testAlt() {
        let alternative = alt(const("L"), alt(const("R1"), const("R2")))
        XCTAssertEqual(alternative.parseValue(from: "L"), SimpleAlt.left("L"))
        XCTAssertNil(alternative.parseValue(from: "R12"))
        XCTAssertNil(alternative.parseValue(from: "R3"))
    }
    
    func testOpt() {
        XCTAssertNil(opt(const("abc")).parseValue(from: "abcdef"))
        XCTAssertNil(opt(const("abc")).parseValue(from: "defabc"))
        XCTAssertEqual(opt(const("abc")).parseValue(from: "abc"), SimpleOpt.from("abc"))
    }
    
    func testRep() {
        XCTAssertEqual(rep(const("A")).parseValue(from: "AAAA")?.values, ["A", "A", "A", "A"])
        XCTAssertEqual(rep(const("A")).parseValue(from: "")?.values, [])
        XCTAssertEqual(rep(const("A")).parseValue(from: "A")?.values, ["A"])
        XCTAssertNil(rep(const("A")).parseValue(from: "AAAAB"))
    }
    
    func testRep1() {
        XCTAssertNil(rep1(const("A")).parseValue(from: ""))
        XCTAssertEqual(rep(const("A")).parseValue(from: "A")?.values, ["A"])
        XCTAssertEqual(rep(const("A")).parseValue(from: "AAA")?.values, ["A", "A", "A"])
    }
    
    fileprivate struct Recursive: Seq, Equatable {
        private let values: [String]
        
        fileprivate init(values: [String]) {
            self.values = values
        }
        
        static func from(_ left: String, _ right: Recursive) -> Recursive {
            return Recursive(values: [left] + right.values)
        }
    }
    
    func testRecursion() {
        let parens = recursive {
            alt(seq(const("("), $0, as: Recursive.self), const(""))
                .map { $0.asLeft ?? Recursive(values: []) }
        }
        XCTAssertNil(parens.parseValue(from: "(((a"))
        XCTAssertEqual(parens.parseValue(from: "((("), Recursive(values: ["(", "(", "("]))
    }
}
