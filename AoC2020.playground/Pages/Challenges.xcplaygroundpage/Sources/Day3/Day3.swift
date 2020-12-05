import Foundation

public struct SlopeNavigator {
    let mapEntries: [String]

    public init(mapData: [String]) {
        self.mapEntries = mapData
    }

    public func treesEncountered(slope: Slope) -> Int {
        var treeCount = 0
        var position = Slope(over: 0, down: 0)
        while position.down < mapEntries.count {
            treeCount += isTree(at: position) ? 1 : 0
            position = position + slope
        }
        return treeCount
    }

    func isTree(at point: Slope) -> Bool {
        return char(at: point) == "#"
    }

    func char(at point: Slope) -> Character? {
        let mapLine = mapEntries[point.down]
        let lineLength = mapLine.count
        guard lineLength > 0 else {
            return nil
        }

        let offset = point.over % lineLength
        return mapLine[mapLine.index(mapLine.startIndex, offsetBy: offset)]
    }
}

public struct Slope: Equatable {
    let over: Int, down: Int

    public init(over: Int, down: Int) {
        self.over = over
        self.down = down
    }

    static func +(lhs: Self, rhs: Self) -> Self {
        return Slope(over: lhs.over + rhs.over, down: lhs.down + rhs.down)
    }
}
