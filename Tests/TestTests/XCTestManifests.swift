import XCTest

extension TestTests {
    static let __allTests = [
        ("testLifetime", testLifetime),
        ("testThrows", testThrows),
    ]
}

#if !os(macOS)
public func __allTests() -> [XCTestCaseEntry] {
    return [
        testCase(TestTests.__allTests),
    ]
}
#endif
