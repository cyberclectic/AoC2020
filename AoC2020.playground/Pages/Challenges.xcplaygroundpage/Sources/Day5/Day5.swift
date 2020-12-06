import Foundation

public struct BoardingPassHandler {

    let boardingPasses: [String]

    var boardingPassIDs: [Int] {
        return boardingPasses.lazy.map({ (Int($0.lazy.map({ $0 == "F" || $0 == "L" ? "0" : "1" }).joined(), radix: 2) ?? 0) }).sorted()
    }

    public init(_ boardingPasses: [String]) {
        self.boardingPasses = boardingPasses
    }

    public var highestSeatID: Int? {
        return boardingPassIDs.last ?? nil
    }

    public var mySeatID: Int? {
        guard let min = boardingPassIDs.first,
              let max = boardingPassIDs.last
        else { return nil }
        return Set(min...max).subtracting(Set(boardingPassIDs)).first
    }
}
