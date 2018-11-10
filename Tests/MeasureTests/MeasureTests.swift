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

import Test
@testable import Measure

class MeasureTests: TestCase {
    func testStringFormat() {
        assertEqual(String(format: "%.1f", 1.618), "1.6")
        assertEqual(String(format: "%.2f", 1.618), "1.62")
        assertEqual(String(format: "%.3f", 1.61803), "1.618")
        assertEqual(String(format: "%.7f", 1.6180339887), "1.6180340")
        assertEqual(String(format: "%.8f", 1.6180339887), "1.61803399")
    }
}
