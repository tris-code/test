import XCTest

extension AtomicConditionTests {
    static let __allTests = [
        ("testAtomicCondition", testAtomicCondition),
    ]
}

extension TestTests {
    static let __allTests = [
        ("testLifetime", testLifetime),
        ("testThrows", testThrows),
    ]
}

#if !os(macOS)
public func __allTests() -> [XCTestCaseEntry] {
    return [
        testCase(AtomicConditionTests.__allTests),
        testCase(TestTests.__allTests),
    ]
}
#endif
