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

extension timeval {
    var ms: Int {
        return Int(tv_sec) * 1_000 + Int(tv_usec) / 1_000
    }
}

extension timeval: CustomStringConvertible {
    public var description: String {
        guard tv_sec == 0 else {
            return String(format: "%.3f", (Double(self.ms) / 1_000))
        }
        switch tv_usec {
        case 0..<1_000: return "\(tv_usec) μs"
        case 1_000...: return "\(tv_usec / 1_000) ms"
        default: fatalError()
        }
    }
}

// MARK: Equatable, Comparable

extension timeval: Equatable {
    /// Returns a Boolean value indicating whether two values are equal.
    ///
    /// Equality is the inverse of inequality. For any values `a` and `b`,
    /// `a == b` implies that `a != b` is `false`.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    public static func ==(lhs: timeval, rhs: timeval) -> Bool {
        return lhs.tv_sec == rhs.tv_sec && lhs.tv_usec == rhs.tv_usec
    }
}

extension timeval: Comparable {
    /// Returns a Boolean value indicating whether the value of the first
    /// argument is less than that of the second argument.
    ///
    /// This function is the only requirement of the `Comparable` protocol. The
    /// remainder of the relational operator functions are implemented by the
    /// standard library for any type that conforms to `Comparable`.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    public static func <(lhs: timeval, rhs: timeval) -> Bool {
        if lhs.tv_sec < rhs.tv_sec {
            return true
        } else if lhs.tv_sec == rhs.tv_sec {
            return lhs.tv_usec < rhs.tv_usec
        } else {
            return false
        }
    }

    /// Returns a Boolean value indicating whether the value of the first
    /// argument is greater than that of the second argument.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    public static func >(lhs: timeval, rhs: timeval) -> Bool {
        if lhs.tv_sec > rhs.tv_sec {
            return true
        } else if lhs.tv_sec == rhs.tv_sec {
            return lhs.tv_usec > rhs.tv_usec
        } else {
            return false
        }
    }
}

// MARK: Partial IntegerArithmetic

extension timeval {
    /// Adds `lhs` and `rhs`, returning the result and trapping in case of
    /// arithmetic overflow (except in -Ounchecked builds).
    static func +(lhs: timeval, rhs: timeval) -> timeval {
        var result = timeval()
        if lhs.tv_usec + rhs.tv_usec >= 1_000_000 {
            result.tv_sec = lhs.tv_sec + rhs.tv_sec + 1
            result.tv_usec = lhs.tv_usec + rhs.tv_usec - 1_000_000
        } else {
            result.tv_sec = lhs.tv_sec + rhs.tv_sec
            result.tv_usec = lhs.tv_usec + rhs.tv_usec
        }
        return result
    }

    /// Subtracts `lhs` and `rhs`, returning the result and trapping in case of
    /// arithmetic overflow (except in -Ounchecked builds).
    static func -(lhs: timeval, rhs: timeval) -> timeval {
        var result = timeval()
        if lhs.tv_usec - rhs.tv_usec < 0 {
            result.tv_sec = lhs.tv_sec - rhs.tv_sec - 1
            result.tv_usec = lhs.tv_usec - rhs.tv_usec + 1_000_000
        } else {
            result.tv_sec = lhs.tv_sec - rhs.tv_sec
            result.tv_usec = lhs.tv_usec - rhs.tv_usec
        }
        return result
    }

    static func /(lhs: timeval, rhs: Int) -> timeval {
        var result = timeval()
        let temp = (Int(lhs.tv_sec) * 1_000_000 + Int(lhs.tv_usec)) / rhs
        result.tv_sec = temp / 1_000_000
    #if os(Linux)
        result.tv_usec = Int(temp % 1_000_000)
    #else
        result.tv_usec = Int32(temp % 1_000_000)
    #endif
        return result
    }
}
