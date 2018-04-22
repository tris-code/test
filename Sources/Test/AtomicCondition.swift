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

import class Foundation.NSCondition

public class AtomicCondition {
    var satisfied = false
    let condition = NSCondition()

    public init() {}

    public func signal() {
        condition.lock()
        satisfied = true
        condition.signal()
        condition.unlock()
    }

    public func wait() {
        condition.lock()
        if !satisfied {
            condition.wait()
        }
        condition.unlock()
    }
}
