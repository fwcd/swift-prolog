import XCTest
@testable import ParserCombinators

final class ParserCombinatorsTests: XCTestCase {
    static var allTests = [
        ("testConst", testConst),
        ("testAlt", testAlt),
    ]
    
    private func testConst() {
        XCTAssertEqual(const("T").parse(from: "Test"), ("T", "est"))
        XCTAssertNil(const("Demo").parse(from: "abc"))
    }

    private func testAlt() {
        let alternative = alt(const("L"), alt(const("R1"), const("R2")))
        XCTAssertEqual(alternative.parse(from: "L"), ("L", ""))
        XCTAssertEqual(alternative.parse(from: "R12"), ("R1", "2"))
        XCTAssertNil(alternative.parse(from: "R3"))
    }
}
