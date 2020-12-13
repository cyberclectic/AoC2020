import Foundation

public struct SeatHandler {
    public enum SeatingPreference {
        case adjacent
        case visible
    }

    public enum PositionIndicator: Character {
        case floor = "."
        case empty = "L"
        case occupied = "#"
    }

    private var positionIndicators: [PositionIndicator]
    private let seatingPreference: SeatingPreference
    private let width: Int
    private let height: Int

    public init(_ input: [String], seatingPreference: SeatingPreference) {
        self.width = input.first?.count ?? 0
        self.height = input.count
        var positionIndicators: [PositionIndicator] = []
        input.forEach { line in
            positionIndicators.append(contentsOf: line.map { PositionIndicator(rawValue: $0)! })
        }
        self.positionIndicators = positionIndicators
        self.seatingPreference = seatingPreference
    }

    public var occupiedSeats: Int {
        return positionIndicators.filter({ $0 == .occupied }).count
    }

    

    mutating public func advance() {
        let occupiedThreshold = (seatingPreference == .adjacent) ? 4 : 5

        positionIndicators = positionIndicators.enumerated().map { (i, position) in
            guard position != .floor else {
                return .floor
            }

            let occupiedCount = countTakenSeats(for: i)
            if position == .empty, occupiedCount == 0 {
                return .occupied
            } else if position == .occupied, occupiedCount >= occupiedThreshold {
                return .empty
            }
            return position
        }
    }

    mutating public func processRules() {
        var prev: [PositionIndicator] = []
        while prev != positionIndicators {
            prev = positionIndicators
            advance()
        }
    }

    let vectors = [(-1, -1), (-1, 0), (-1, 1), (0, -1), (0, 1), (1, -1), (1, 0), (1, 1)]

    public func countTakenSeats(for index: Int) -> Int {
        return vectors.filter { (vectorRow, vectorCol) in
            var row = index / width + vectorRow
            var column = index % width + vectorCol

            while row >= 0 && row < height && column >= 0 && column < width {
                if let occupied = isSeatTakenAt(row: row, column: column) {
                    return occupied
                }

                guard seatingPreference == .visible else {
                    break
                }
                row += vectorRow
                column += vectorCol
            }
            return false
        }.count
    }

    func isSeatTakenAt(row: Int, column: Int) -> Bool? {
            switch positionIndicators[row * width + column] {
            case .floor:
                return nil
            case .empty:
                return false
            case .occupied:
                return true
            }
        }
}
