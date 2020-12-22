import Foundation
import XCTest

import Challenges_PageSources

let testObserver = TestObserver()
XCTestObservationCenter.shared.addTestObserver(testObserver)

// MARK: Day 1

class Day1Tests: XCTestCase {

    var day1TestData: [Int]!
    var report: ExpenseReport!

    override func setUp() {
        day1TestData = InputFileReader.readInput("Day1Test").compactMap({ Int($0) })

        report = ExpenseReport(day1TestData)
    }

    func testfindProduct() {
        let day1Test1 = report.findProduct(sum: 2020, lineItemCount: 2)
        XCTAssertNotNil(day1Test1)
        XCTAssertEqual(day1Test1, 514579, "Day 1: Test 1 - Failed.")

        let day1Test2 = report.findProduct(sum: 2020, lineItemCount: 3)
        XCTAssertNotNil(day1Test2)
        XCTAssertEqual(day1Test2, 241861950, "Day 1: Test 2 - Failed.")
    }
}
Day1Tests.defaultTestSuite.run()

// MARK: Day 2

class Day2Tests: XCTestCase {
    var day2TestData: [String]!
    var passwordValidator: PasswordValidator!

    override func setUp() {
        day2TestData = InputFileReader.readInput("Day2Test")

        passwordValidator = PasswordValidator(day2TestData)
    }

    func testCheckPasswords() {
        let day2Test1 = passwordValidator.checkPasswords(with: .count)
        XCTAssertNotNil(day2Test1)
        XCTAssertEqual(day2Test1, 2, "Day 2: Test 1 - Failed.")

        let day2STest2 = passwordValidator.checkPasswords(with: .location)
        XCTAssertNotNil(day2STest2)
        XCTAssertEqual(day2STest2, 1, "Day 2: Test 2 - Failed.")
    }
}
Day2Tests.defaultTestSuite.run()

// MARK: Day 3

class Day3Tests: XCTestCase {
    var day3TestData: [String]!
    var navigator: SlopeNavigator!

    let slopes = [
        (1, 1),
        (3, 1),
        (5, 1),
        (7, 1),
        (1, 2)
    ]

    override func setUp() {
        day3TestData = InputFileReader.readInput("Day3Test")

        navigator = SlopeNavigator(mapData: day3TestData)
    }

    func testTreesEncountered() {
        let day3Test1 = navigator.treesEncountered(.init(over: slopes[1].0, down: slopes[1].1))
        XCTAssertNotNil(day3Test1)
        XCTAssertEqual(day3Test1, 7, "Day 3: Test 1 - Failed.")

        let day3Test2 = slopes.map({ navigator.treesEncountered(.init(over: $0.0, down: $0.1)) }).reduce(1, *)
        XCTAssertNotNil(day3Test2)
        XCTAssertEqual(day3Test2, 336, "Day 3: Test 2 - Failed.")
    }
}
Day3Tests.defaultTestSuite.run()

// MARK: Day 4

class Day4Tests: XCTestCase {
    var day4TestData: [String]!
    var passportValidator: PassportValidator!

    override func setUp() {
        day4TestData = InputFileReader.readInput("Day4Test", stringSeperator: "\n\n")

        passportValidator = PassportValidator(day4TestData)
    }

    func testCountValidPassports() {
        let day4Test1 = passportValidator.countValidPassports()
        XCTAssertNotNil(day4Test1)
        XCTAssertEqual(day4Test1, 10, "Day 4: Test 1 - Failed.")

        passportValidator.validationType = .validateRequiredFieldValues
        let day4Test2 = passportValidator.countValidPassports()
        XCTAssertNotNil(day4Test2)
        XCTAssertEqual(day4Test2, 6, "Day 4: Test 2 - Failed.")
    }
}
Day4Tests.defaultTestSuite.run()

// MARK: Day 5

class Day5Tests: XCTestCase {
    var day5TestData: [String]!
    var boardingPassHandler: BoardingPassHandler!

    override func setUp() {
        day5TestData = InputFileReader.readInput("Day5Test")

        boardingPassHandler = BoardingPassHandler(day5TestData)
    }

    func testHighestSeatID() {

        let day5Test1 = boardingPassHandler.highestSeatID
        XCTAssertNotNil(day5Test1)
        XCTAssertEqual(day5Test1, 959, "Day 5: Test 1 - Failed.")

        let day5Test2 = boardingPassHandler.mySeatID
        XCTAssertNotNil(day5Test2)
        XCTAssertEqual(day5Test2, 958, "Day 5: Test 2 - Failed.")
    }
}
Day5Tests.defaultTestSuite.run()

// MARK: Day 6

class Day6Tests: XCTestCase {
    var day6TestData: [String]!
    var customsFormHandler: CustomsFormsHandler!

    override func setUp() {

        day6TestData = InputFileReader.readInput("Day6Test", stringSeperator: "\n\n")
        customsFormHandler = CustomsFormsHandler(day6TestData, validationType: .anyoneInGroupPositive)
    }

    func testDay6() {
        let day6Test1 = customsFormHandler.customsTotals
        XCTAssertNotNil(day6Test1)
        XCTAssertEqual(day6Test1, 11, "Day 6: Test 1 - Failed.")

        customsFormHandler.validationType = .everyoneInGroupPositive
        let day6Test2 = customsFormHandler.customsTotals
        XCTAssertNotNil(day6Test2)
        XCTAssertEqual(day6Test2, 6, "Day 6: Test 2 - Failed.")
    }
}
Day6Tests.defaultTestSuite.run()

// MARK: Day 7

class Day7Tests: XCTestCase {

        var day7TestData: [String]!
        var bagHandler: BagHandler!

        override func setUp() {

            day7TestData = InputFileReader.readInput("Day7Test")
            bagHandler = BagHandler(day7TestData)
        }

        func testDay7() {
            let day7Test1 = bagHandler.possibleBags(for: "shiny gold").count
            XCTAssertNotNil(day7Test1)
            XCTAssertEqual(day7Test1, 4, "Day 7: Test 1 - Failed.")

            let day7Test2 = bagHandler.bagContainsCount(by: "shiny gold")
            XCTAssertNotNil(day7Test2)
            XCTAssertEqual(day7Test2, 32, "Day 7: Test 2 - Failed.")
        }
}
Day7Tests.defaultTestSuite.run()

// MARK: Day 8

class Day8Tests: XCTestCase {

    var day8TestData: [String]!
    var instructionHandler: InstructionHandler!

    override func setUp() {

        day8TestData = InputFileReader.readInput("Day8Test")
        instructionHandler = InstructionHandler(day8TestData)
    }

    func testDay8() {
        XCTAssertEqual(instructionHandler.accumulatedTotal().value, 5, "Day 8: Test 1 - Failed.")
        XCTAssertEqual(instructionHandler.completedTotal, 8, "Day 8: Test 2 - Failed.")
    }
}
Day8Tests.defaultTestSuite.run()

// MARK: Day 9

class Day9Tests: XCTestCase {

    var day9TestData: [String]!
    var cypherHandler: CypherHandler!

    override func setUp() {

        day9TestData = InputFileReader.readInput("Day9Test")
        cypherHandler = CypherHandler(day9TestData)
    }

    func testDay9() {
        XCTAssertEqual(cypherHandler.cypherNonSum(withPreamble: 5), 127, "Day 9: Test 1 - Failed.")
        XCTAssertEqual(cypherHandler.cypherWeakness(withPreamble: 5), 62, "Day 9: Test 2 - Failed.")
    }
}
Day9Tests.defaultTestSuite.run()

// MARK: Day 10

class Day10Tests: XCTestCase {

    var day10TestData: [String]!
    var adapterHandler: AdapterHandler!

    override func setUp() {

        day10TestData = InputFileReader.readInput("Day10Test")
        adapterHandler = AdapterHandler(day10TestData)
    }

    func testDay10() {
        XCTAssertEqual(adapterHandler.adapterProduct, 220, "Day 10: Test 1 - Failed.")
        XCTAssertEqual(adapterHandler.adapterPossibilities, 19208, "Day 10: Test 2 - Failed.")
    }
}
Day10Tests.defaultTestSuite.run()

// MARK: Day 11

class Day11Tests: XCTestCase {

    var day11TestData: [String]!
    var seatHandler: SeatHandler!

    override func setUp() {

        day11TestData = InputFileReader.readInput("Day11Test")
    }

    func testDay11() {
        seatHandler = SeatHandler(day11TestData, seatingPreference: .adjacent)
        seatHandler.processRules()
        XCTAssertEqual(seatHandler.occupiedSeats, 37, "Day 11: Test 1 - Failed.")

        seatHandler = SeatHandler(day11TestData, seatingPreference: .visible)
        seatHandler.processRules()
        XCTAssertEqual(seatHandler.occupiedSeats, 26, "Day 11: Test 2 - Failed.")
    }
}
Day11Tests.defaultTestSuite.run()

// MARK: Day 12

class Day12Tests: XCTestCase {

    var day12TestData: [String]!
    var shipHandler: ShipHandler!

    override func setUp() {

        day12TestData = InputFileReader.readInput("Day12Test")
    }

    func testDay12() {
        shipHandler = ShipHandler(day12TestData)
        XCTAssertEqual(shipHandler.manhattanDistance(navigationType: .grid), 25, "Day 12: Test 1 - Failed.")
        shipHandler = ShipHandler(day12TestData)
        XCTAssertEqual(shipHandler.manhattanDistance(navigationType: .waypoint), 286, "Day 12: Test 2 - Failed.")
    }
}
Day12Tests.defaultTestSuite.run()

// MARK: Day 13

class Day13Tests: XCTestCase {

    var day13TestData: [String]!
    var shuttleHandler: ShuttleHandler!

    override func setUp() {

        day13TestData = InputFileReader.readInput("Day13Test")
        shuttleHandler = ShuttleHandler(day13TestData)
    }

    func testDay13() {
        XCTAssertEqual(shuttleHandler.earliestBusProduct, 295, "Day 13: Test 1 - Failed.")
        XCTAssertEqual(shuttleHandler.earliestSynchronizedDeparture, 1068781, "Day 13: Test 2 - Failed.")
    }
}
Day13Tests.defaultTestSuite.run()

// MARK: Day 14

class Day14Tests: XCTestCase {

    var day14TestData: [String]!
    var memoryHandler: MemoryHandler!

    override func setUp() {

        day14TestData = InputFileReader.readInput("Day14Test")
        memoryHandler = MemoryHandler(day14TestData)
    }

    func testDay14() {
        XCTAssertEqual(memoryHandler.memoryValuesTotal(), 165, "Day 14: Test 1 - Failed.")
        day14TestData = InputFileReader.readInput("Day14Test2")
        memoryHandler = MemoryHandler(day14TestData)
        XCTAssertEqual(memoryHandler.memoryValuesTotalV2(), 208, "Day 14: Test 2 - Failed.")
    }
}
Day14Tests.defaultTestSuite.run()

// MARK: Day 15

class Day15Tests: XCTestCase {

    var day15TestData: [String]!
    var numberSpeaker: NumberSpeaker!

    override func setUp() {

        day15TestData = InputFileReader.readInput("Day15Test")
        numberSpeaker = NumberSpeaker(day15TestData)
    }

    func testDay14() {
        XCTAssertEqual(numberSpeaker.getNumberSpoken(at: 2020), 436, "Day 15: Test 1 - Failed.")
        XCTAssertEqual(numberSpeaker.getNumberSpoken(at: 30000000), 175594, "Day 15: Test 2 - Failed.")
    }
}
Day15Tests.defaultTestSuite.run()
