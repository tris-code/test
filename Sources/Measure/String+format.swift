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

#if os(macOS)
import Darwin
#else
import Glibc
#endif

extension String {
    init(format: String, _ value: Double) {
        let factor: Double
        switch format {
        case "%.1f": factor = 10
        case "%.2f": factor = 100
        case "%.3f": factor = 1000
        default:
            guard format.starts(with: "%."), 
                format.last == "f", 
                format.count > 3,
                let count = Int(format.dropFirst(2).dropLast(1)) else 
            {
                self.init(value)
                return
            }
            factor = pow(10, Double(count))
        }
        let integer = Int(value)
        let fract = value.truncatingRemainder(dividingBy: 1)
        let rounded = Int((fract * factor).rounded())
        self.init(String(integer) + "." + String(rounded))
    }
}
