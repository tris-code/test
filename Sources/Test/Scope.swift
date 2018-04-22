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

import XCTest

public func scope(
    file: StaticString = #file,
    line: UInt = #line,
    task: () throws -> Void)
{
    do {
        try task()
    } catch {
        XCTFail(String(describing: error), file: file, line: line)
    }
}
