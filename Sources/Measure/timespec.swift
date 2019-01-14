#if os(macOS)
import Darwin
#else
import Glibc
#endif

extension timespec {
    @inline(__always)
    static func now() -> timespec {
        var ts = timespec()
        #if os(macOS) || os(iOS)
            if #available(OSX 10.12, *) {
                clock_gettime(CLOCK_MONOTONIC, &ts)
            } else {
                var info = mach_timebase_info_data_t()
                if info.numer == 0 || info.denom == 0 {
                    mach_timebase_info(&info)
                }
                let time = mach_absolute_time() * UInt64(info.numer / info.denom);
                ts.tv_sec = Int(time / 1_000_000_000)
                ts.tv_nsec = Int(time % 1_000_000_000)
            };
        #else
            clock_gettime(CLOCK_MONOTONIC, &ts)
        #endif
        return ts
    }
}

extension timespec {
    var ms: Int {
        return tv_sec * 1_000 + tv_nsec / 1_000_000
    }

    var us: Int {
        return tv_sec * 1_000_000 + tv_nsec / 1_000
    }

    var ns: Int {
        return tv_sec * 1_000_000_000 + tv_nsec
    }
}

extension timespec: CustomStringConvertible {
    public var description: String {
        guard tv_sec == 0 else {
            return String(format: "%.3f s", (Double(self.ms) / 1_000))
        }
        switch tv_nsec {
        case 0..<1_000: return "\(tv_nsec) ns"
        case 1_000..<1_000_000: return "\(tv_nsec / 1_000) μs"
        case 1_000_000...: return "\(tv_nsec / 1_000_000) ms"
        default: fatalError()
        }
    }
}

/// Equatable, Comparable

extension timespec: Equatable {
    /// Returns a Boolean value indicating whether two values are equal.
    ///
    /// Equality is the inverse of inequality. For any values `a` and `b`,
    /// `a == b` implies that `a != b` is `false`.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    public static func ==(lhs: timespec, rhs: timespec) -> Bool {
        return lhs.tv_sec == rhs.tv_sec && lhs.tv_nsec == rhs.tv_nsec
    }
}

extension timespec: Comparable {
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
    public static func <(lhs: timespec, rhs: timespec) -> Bool {
        if lhs.tv_sec < rhs.tv_sec {
            return true
        } else if lhs.tv_sec == rhs.tv_sec {
            return lhs.tv_nsec < rhs.tv_nsec
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
    public static func >(lhs: timespec, rhs: timespec) -> Bool {
        if lhs.tv_sec > rhs.tv_sec {
            return true
        } else if lhs.tv_sec == rhs.tv_sec {
            return lhs.tv_nsec > rhs.tv_nsec
        } else {
            return false
        }
    }
}

/// partial IntegerArithmetic

extension timespec {
    /// Adds `lhs` and `rhs`, returning the result and trapping in case of
    /// arithmetic overflow (except in -Ounchecked builds).
    static func +(lhs: timespec, rhs: timespec) -> timespec {
        var result = timespec()
        if lhs.tv_nsec + rhs.tv_nsec >= 1_000_000_000 {
            result.tv_sec = lhs.tv_sec + rhs.tv_sec + 1
            result.tv_nsec = lhs.tv_nsec + rhs.tv_nsec - 1_000_000_000
        } else {
            result.tv_sec = lhs.tv_sec + rhs.tv_sec
            result.tv_nsec = lhs.tv_nsec + rhs.tv_nsec
        }
        return result
    }

    /// Subtracts `lhs` and `rhs`, returning the result and trapping in case of
    /// arithmetic overflow (except in -Ounchecked builds).
    static func -(lhs: timespec, rhs: timespec) -> timespec {
        var result = timespec()
        if lhs.tv_nsec - rhs.tv_nsec < 0 {
            result.tv_sec = lhs.tv_sec - rhs.tv_sec - 1
            result.tv_nsec = lhs.tv_nsec - rhs.tv_nsec + 1_000_000_000
        } else {
            result.tv_sec = lhs.tv_sec - rhs.tv_sec
            result.tv_nsec = lhs.tv_nsec - rhs.tv_nsec
        }
        return result
    }

    static func /(lhs: timespec, rhs: Int) -> timespec {
        var result = timespec()
        let temp = (Int(lhs.tv_sec) * 1_000_000_000 + Int(lhs.tv_nsec)) / rhs
        result.tv_sec = temp / 1_000_000_000
        result.tv_nsec = temp % 1_000_000_000
        return result
    }
}
