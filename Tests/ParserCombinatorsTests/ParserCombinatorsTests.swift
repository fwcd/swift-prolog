import XCTest
@testable import ParserCombinators

final class ParserCombinatorsTests: XCTestCase {
    static var allTests = [
        ("testConst", testConst),
        ("testAlt", testAlt),
    ]
    
    private func testConst() {
        let (l, s) = const("T").parse(from: "Test")!
        XCTAssertEqual(l, "T")
        XCTAssertEqual(s, "est")
        XCTAssertNil(const("Demo").parse(from: "abc"))
    }

    private func testAlt() {
        let alternative: AltParser<
            ConstParser,
            AltParser<
                ConstParser,
                ConstParser,
                SimpleAlt<String, String>
            >,
            SimpleAlt<String, SimpleAlt<String, String>>
        > = alt(const("L"), alt(const("R1"), const("R2")))
        XCTAssertEqual(alternative.parseValue(from: "L"), SimpleAlt.left("L"))
        XCTAssertEqual(alternative.parseValue(from: "R12"), SimpleAlt.right(SimpleAlt.left("R1")))
        XCTAssertNil(alternative.parseValue(from: "R3"))
    }
}
