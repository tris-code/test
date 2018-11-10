import XCTest

extension MeasureTests {
    static let __allTests = [
        ("testStringFormat", testStringFormat),
    ]
}

#if !os(macOS)
public func __allTests() -> [XCTestCaseEntry] {
    return [
        testCase(MeasureTests.__allTests),
    ]
}
#endif
