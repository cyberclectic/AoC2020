import Foundation

public struct Rule {
    let ruleName: String
    let validRanges: [ClosedRange<Int>]

    public init(from input: String) {
        // Get rule name.
        let scanner = Scanner(string: input)
        self.ruleName = scanner.scanUpToString(":")!

        // Get first set of rule ranges.
        _ = scanner.scanCharacter()
        var ranges: [ClosedRange<Int>] = []
        guard let rangeStart = scanner.scanInt(),
              scanner.scanString("-") != nil,
              let rangeEnd = scanner.scanInt() else {
            fatalError()
        }
        ranges.append(rangeStart...rangeEnd)

        // Get second set of rule ranges.
        _ = scanner.scanString("or")
        guard let secondRangeStart = scanner.scanInt(),
              scanner.scanString("-") != nil,
              let secondRangeEnd = scanner.scanInt() else {
            fatalError()
        }
        ranges.append(secondRangeStart...secondRangeEnd)
        self.validRanges = ranges
    }

    public func validFields(for ticket: [Int]) -> [Int] {
        return ticket.filter({ contains($0) })
    }

    public func contains(_ value: Int) -> Bool {
        return validRanges.first(where: { $0.contains(value) }) != nil
    }
}
