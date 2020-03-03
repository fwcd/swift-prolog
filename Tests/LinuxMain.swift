import XCTest

import ParserCombinatorTests
import PrologSyntaxTests

var tests = [XCTestCaseEntry]()
tests += ParserCombinatorTests.allTests()
tests += PrologSyntaxTests.allTests()
XCTMain(tests)
