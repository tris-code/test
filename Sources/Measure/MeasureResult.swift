#if os(macOS)
import Darwin
#else
import Glibc
#endif

public struct MeasureResult {
    public var time: timespec

    public let user: timeval
    public let system: timeval

    public let iterations: Int

    public var tasksPerSecond: Int {
        guard time.ns > 0 else {
            return -1
        }
        return iterations * 1_000_000_000 / time.ns
    }
}

extension Array where Element == MeasureResult {
    public var average: MeasureResult {
        let time = self.map({ $0.time }).reduce(timespec(), +) / self.count
        let user = self.map({ $0.user }).reduce(timeval(), +) / self.count
        let system = self.map({ $0.system }).reduce(timeval(), +) / self.count
        let iterations = self.map({ $0.iterations }).reduce(0, +) / self.count
        return MeasureResult(time: time, user: user, system: system, iterations: iterations)
    }

    public var description: String {
        return average.description
    }
}

extension MeasureResult: CustomStringConvertible {
    public var description: String {
        return "\(tasksPerSecond) tasks/sec | time: \(time) | user: \(user) system: \(system)"
    }
}
