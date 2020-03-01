import XCTest

import ParserCombinatorsTests
import PrologTests

var tests = [XCTestCaseEntry]()
tests += ParserCombinatorsTests.allTests()
tests += PrologTests.allTests()
XCTMain(tests)
