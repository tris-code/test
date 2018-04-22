/******************************************************************************
 *                                                                            *
 * Tris Foundation disclaims copyright to this source code.                   *
 * In place of a legal notice, here is a blessing:                            *
 *                                                                            *
 *     May you do good and not evil.                                          *
 *     May you find forgiveness for yourself and forgive others.              *
 *     May you share freely, never taking more than you give.                 *
 *                                                                            *
 ******************************************************************************/

@testable import Test
class TestTests: TestCase {
    func testThrows() {
        func throwsError() throws {}
        scope {
            try throwsError()
        }
    }

    func testLifetime() {
        class Test {
            let descrtuctor: () -> Void

            init(_ descrtuctor: @escaping () -> Void) {
                self.descrtuctor = descrtuctor
            }

            deinit {
                descrtuctor()
            }
        }

        var called = false
        scope {
            _ = Test {
                called = true
            }
        }
        assertTrue(called)
    }
}
