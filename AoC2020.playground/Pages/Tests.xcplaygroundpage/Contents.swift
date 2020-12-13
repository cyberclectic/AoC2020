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
        day1TestData = InputFileReader.readInput(id: "Day1Test").compactMap({ Int($0) })

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
        day2TestData = InputFileReader.readInput(id: "Day2Test")

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
        day3TestData = InputFileReader.readInput(id: "Day3Test")

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
        day4TestData = InputFileReader.readInput(id: "Day4Test", stringSeperator: "\n\n")

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
        day5TestData = InputFileReader.readInput(id: "Day5Test")

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

        day6TestData = InputFileReader.readInput(id: "Day6Test", stringSeperator: "\n\n")
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

            day7TestData = InputFileReader.readInput(id: "Day7Test")
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

        day8TestData = InputFileReader.readInput(id: "Day8Test")
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

        day9TestData = InputFileReader.readInput(id: "Day9Test")
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

        day10TestData = InputFileReader.readInput(id: "Day10Test")
        adapterHandler = AdapterHandler(day10TestData)
    }

    func testDay9() {
        XCTAssertEqual(adapterHandler.adapterProduct, 220, "Day 10: Test 1 - Failed.")
        XCTAssertEqual(adapterHandler.adapterPossibilities, 19208, "Day 10: Test 2 - Failed.")
    }
}
Day10Tests.defaultTestSuite.run()
