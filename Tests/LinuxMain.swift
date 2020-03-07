import XCTest

import ParserCombinatorTests
import PrologInterpreterTests
import PrologSyntaxTests

var tests = [XCTestCaseEntry]()
tests += ParserCombinatorTests.allTests()
tests += PrologInterpreterTests.allTests()
tests += PrologSyntaxTests.allTests()
XCTMain(tests)
