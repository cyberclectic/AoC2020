import Foundation
import XCTest

import Challenges_PageSources

// Test Observer
class TestObserver: NSObject, XCTestObservation {
    public func testCase(_ testCase: XCTestCase,
                  didFailWithDescription description: String,
                  inFile filePath: String?,
                  atLine lineNumber: Int) {
        assertionFailure("🛑🛑🛑 " + description, line: UInt(lineNumber))
    }
}

let testObserver = TestObserver()
XCTestObservationCenter.shared.addTestObserver(testObserver)

// MARK: Day 1

class Day1Tests: XCTestCase {

    var day1TestData: [Int]!
    var report: ExpenseReport!

    override func setUp() {
        day1TestData = InputFileReader.readInput(id: "Day1Test").compactMap({ Int($0) })

        report = ExpenseReport(lineItems: day1TestData)
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

        passwordValidator = PasswordValidator(passwords: day2TestData)
    }

    func testCheckPasswords() {
        let day2Test1 = passwordValidator.checkPasswords(policy: .count)
        XCTAssertNotNil(day2Test1)
        XCTAssertEqual(day2Test1, 2, "Day 2: Test 1 - Failed.")

        let day2STest2 = passwordValidator.checkPasswords(policy: .location)
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
        let day3Test1 = navigator.treesEncountered(slope: .init(over: slopes[1].0, down: slopes[1].1))
        XCTAssertNotNil(day3Test1)
        XCTAssertEqual(day3Test1, 7, "Day 3: Test 1 - Failed.")

        let day3Test2 = slopes.map({ navigator.treesEncountered(slope: .init(over: $0.0, down: $0.1)) }).reduce(1, *)
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

        passportValidator = PassportValidator(passportData: day4TestData)
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
