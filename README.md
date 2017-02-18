# Test

Just a wrapper around XCTest for convenience.

## Memo

```swift
class TestCase: XCTestCase {}

func assert(_ expression: Bool, _ message: String = default)
func assertNil(_ expression: Any?, _ message: String = default)
func assertNotNil(_ expression: Any?, _ message: String = default)
func assertTrue(_ expression: Bool, _ message: String = default)
func assertFalse(_ expression: Bool, _ message: String = default)
func assertEqual<T>(_ expression1: T, _ expression2: T, _ message: String = default) where T : Equatable
func assertEqual<T>(_ expression1: T?, _ expression2: T?, _ message: String = default) where T : Equatable
func assertEqual<T>(_ expression1: ArraySlice<T>, _ expression2: ArraySlice<T>, _ message: String = default) where T : Equatable
func assertEqual<T>(_ expression1: ContiguousArray<T>, _ expression2: ContiguousArray<T>, _ message: String = default) where T : Equatable
func assertEqual<T>(_ expression1: [T], _ expression2: [T], _ message: String = default) where T : Equatable
func assertEqual<T, U>(_ expression1: [T : U], _ expression2: [T : U], _ message: String = default) where T : Hashable, U : Equatable
func assertEqualWithAccuracy<T>(_ expression1: T, _ expression2: T, accuracy: T, _ message: String = default) where T : FloatingPoint
func assertGreaterThan<T>(_ expression1: T, _ expression2: T, _ message: String = default) where T : Comparable
func assertGreaterThanOrEqual<T>(_ expression1: T, _ expression2: T, _ message: String = default) where T : Comparable
func assertLessThan<T>(_ expression1: T, _ expression2: T, _ message: String = default) where T : Comparable
func assertLessThanOrEqual<T>(_ expression1: T, _ expression2: T, _ message: String = default) where T : Comparable
func assertNotEqual<T>(_ expression1: T, _ expression2: T, _ message: String = default) where T : Equatable
func assertNotEqual<T>(_ expression1: T?, _ expression2: T?, _ message: String = default) where T : Equatable
func assertNotEqual<T>(_ expression1: ArraySlice<T>, _ expression2: ArraySlice<T>, _ message: String = default) where T : Equatable
func assertNotEqual<T>(_ expression1: ContiguousArray<T>, _ expression2: ContiguousArray<T>, _ message: String = default) where T : Equatable
func assertNotEqual<T>(_ expression1: [T], _ expression2: [T], _ message: String = default) where T : Equatable
func assertNotEqual<T, U>(_ expression1: [T : U], _ expression2: [T : U], _ message: String = default) where T : Hashable, U : Equatable
func assertNotEqualWithAccuracy<T>(_ expression1: T, _ expression2: T, accuracy: T, _ message: String = default) where T : FloatingPoint
func assertThrowsError<T>(_ expression: T, _ message: String = default, _ errorHandler: (_ error: Error) -> Void = default)
func assertNoThrow<T>(_ expression: T, _ message: String = default)
func fail(_ message: String = default)
```
