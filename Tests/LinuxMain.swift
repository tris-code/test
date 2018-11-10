import XCTest

import MeasureTests
import TestTests

var tests = [XCTestCaseEntry]()
tests += MeasureTests.__allTests()
tests += TestTests.__allTests()

XCTMain(tests)
