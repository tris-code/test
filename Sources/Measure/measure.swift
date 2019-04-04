#if os(macOS)
import Darwin
#else
import Glibc
#endif

#if os(Linux)
let RUSAGE_SELF = Int32(Glibc.RUSAGE_SELF.rawValue)
#endif

public func best(
    from count: Int, _ task: () throws -> MeasureResult
) rethrows -> MeasureResult {
    precondition(count > 0)
    var results = [MeasureResult]()
    for _ in 0..<count {
        results.append(try task())
    }
    return results.best!
}

public func average(
    of count: Int, _ task: () throws -> MeasureResult
) rethrows -> MeasureResult {
    var results = [MeasureResult]()
    for _ in 0..<count {
        results.append(try task())
    }
    return results.average
}

@inline(__always)
public func measure(
    repeat count: Int = 1, _ task: () throws -> Void
) rethrows -> MeasureResult {
    return try measure(repeat: count, { _ in try task() })
}

public func measure(
    repeat count: Int = 1, _ task: (Int) throws -> Void
) rethrows -> MeasureResult {
    var usageStart = rusage()
    var usageEnd = rusage()

    getrusage(RUSAGE_SELF, &usageStart)
    let start = timespec.now()
    for i in 0..<count {
        try task(i)
    }
    let end = timespec.now()
    getrusage(RUSAGE_SELF, &usageEnd)

    let time = end - start
    let user = usageEnd.ru_utime - usageStart.ru_utime
    let system = usageEnd.ru_stime - usageStart.ru_stime

    return MeasureResult(
        time: time,
        user: user,
        system: system,
        iterations: count
    )
}
