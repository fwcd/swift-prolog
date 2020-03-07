import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(SubstitutionTests.allTests),
        testCase(UnificationTests.allTests)
    ]
}
#endif
