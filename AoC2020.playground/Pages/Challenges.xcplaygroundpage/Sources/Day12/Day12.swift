import Foundation

public struct ShipHandler {
    enum Action: Character {
        case north = "N"
        case south = "S"
        case east = "E"
        case west = "W"
        case left = "L"
        case right = "R"
        case forward = "F"
    }

    public enum Heading: Int {
        case east
        case west
        case north
        case south
    }

    public enum NavigationType {
        case grid
        case waypoint
    }

    private struct LineAction {
        var action: Action
        var value: Int
    }

    var currentHeading: Heading = .east
    var currentShipRow: Int = 0
    var currentShipColumn: Int = 0

    private var lineActions: [LineAction] = []

    public init (_ instructions: [String]) {

        for instruction in instructions {
            let lineScanner = Scanner(string: instruction)
            guard let action = Action(rawValue: lineScanner.scanCharacter() ?? "U"),
                  let value = lineScanner.scanInt() else {
                fatalError() }

            let lineAction = LineAction(action: action, value: value)
            lineActions.append(lineAction)
        }
    }

    public mutating func manhattanDistance(navigationType: NavigationType) -> Int {

        processRules(navigationType: navigationType)
        return abs(currentShipRow) + abs(currentShipColumn)
    }

    private mutating func processRules(navigationType: NavigationType) {

        switch navigationType {
        case .grid:
            gridOrientation()
        case .waypoint:
            waypointOrientation()
        }
    }

    private mutating func gridOrientation() {

        let directions: [(east: Int, north: Int)] = [(1, 0), (0, -1), (-1, 0), (0, 1)]
        var direction = ShipHandler.Heading.east.rawValue
        var ship = (east: 0, north: 0)

        lineActions.forEach {
            switch $0.action {
            case .north: ship.north += $0.value
            case .south: ship.north -= $0.value
            case .east: ship.east += $0.value
            case .west: ship.east -= $0.value
            case .left: direction =  (direction - $0.value / 90) %% directions.count
            case .right: direction = (direction + $0.value / 90) %% directions.count
            case .forward:
                ship.east += directions[direction].east * $0.value
                ship.north += directions[direction].north * $0.value
            }
        }

        currentShipRow = ship.north
        currentShipColumn = ship.east
    }

    private mutating func waypointOrientation() {

        var ship = (east: 0, north: 0)
        var waypoint = (east: 10, north: 1)

        lineActions.forEach {
            switch $0.action {
            case .north: waypoint.north += $0.value
            case .south: waypoint.north -= $0.value
            case .east: waypoint.east += $0.value
            case .west: waypoint.east -= $0.value
            case .left: ($0.value / 90).waypointValidator { (waypoint.east, waypoint.north) = (-waypoint.north, waypoint.east) }
            case .right: ($0.value / 90).waypointValidator { (waypoint.east, waypoint.north) = (waypoint.north, -waypoint.east) }
            case .forward:
                ship.east += waypoint.east * $0.value
                ship.north += waypoint.north * $0.value
            }
        }

        currentShipColumn = ship.east
        currentShipRow = ship.north
    }
}

infix operator %%
func %% (_ lhs: Int, _ rhs: Int) -> Int { lhs % rhs >= 0 ? lhs % rhs : lhs % rhs + rhs }
