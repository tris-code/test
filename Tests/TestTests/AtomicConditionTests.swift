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

import Dispatch
@testable import Test

class AtomicConditionTests: TestCase {
    func testAtomicCondition() {
        let condition1 = AtomicCondition()
        let condition2 = AtomicCondition()
        let condition3 = AtomicCondition()

        DispatchQueue.global(qos: .background).async {
            condition2.signal()
            condition1.wait()
            condition3.signal()
        }

        condition2.wait()
        condition1.signal()
        condition3.wait()

        assertTrue(condition1.satisfied)
        assertTrue(condition2.satisfied)
        assertTrue(condition3.satisfied)
    }
}
