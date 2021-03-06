import XCTest
@testable import ParserCombinators

final class ParserCombinatorTests: XCTestCase {
    static let allTests = [
        ("testConst", testConst),
        ("testAlt", testAlt),
        ("testOpt", testOpt),
        ("testSeq", testSeq),
        ("testRep", testRep),
        ("testRep1", testRep1),
        ("testSep", testSep),
        ("testRecursion", testRecursion)
    ]
    
    func testConst() {
        let (l, s) = const("T").parse(from: "Test")!
        XCTAssertEqual(l, "T")
        XCTAssertEqual(s, "est")
        XCTAssertNil(const("Demo").parse(from: "abc"))
        XCTAssertNil(const("12").parseValue(from: "12  "))
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
    
    func testSeq() {
        XCTAssertEqual(seq(const("abc"), const("def")).parseValue(from: "abcdef"), SimpleSeq.from("abc", "def"))
        XCTAssertEqual(seqRight(const("12"), const("34")).parseValue(from: "1234"), "34")
        XCTAssertEqual(seqLeft(const("12"), whitespace()).parseValue(from: "12  "), "12")
        XCTAssertEqual(seqCenter(const("("), try! regex("[^)]+"), const(")")).parseValue(from: "(test)"), "test")
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
    
    func testSep() {
        let parser = sep(const("123"), by: const(","))
        XCTAssertEqual(parser.parseValue(from: "")?.values, [])
        XCTAssertEqual(parser.parseValue(from: "123")?.values, ["123"])
        XCTAssertEqual(parser.parseValue(from: "123,123,123")?.values, ["123", "123", "123"])
        XCTAssertNil(parser.parseValue(from: "123, 123"))
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
