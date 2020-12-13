import Foundation

// MARK: Day 1

let dayOneData = InputFileReader.readInput(id: "Day1").compactMap({ Int($0) })

let report = ExpenseReport(dayOneData)

if let day1Solution1 = report.findProduct(sum: 2020, lineItemCount: 2),
   let day1Solution2 = report.findProduct(sum: 2020, lineItemCount: 3) {

    SolutionOutputHandler.writeOutput(challengeName: "Day 1: Report Repair", firstSolution: day1Solution1, secondSolution: day1Solution2)
}

// MARK: Day 2

let dayTwoData = InputFileReader.readInput(id: "Day2")

let passwordValidator = PasswordValidator(dayTwoData)
let day2Solution1 = passwordValidator.checkPasswords(with: .count)
let day2Solution2 = passwordValidator.checkPasswords(with: .location)

SolutionOutputHandler.writeOutput(challengeName: "Day 2: Password Philosophy", firstSolution: day2Solution1, secondSolution: day2Solution2)

// MARK: Day 3

let dayThreeData = InputFileReader.readInput(id: "Day3")

let navigator = SlopeNavigator(mapData: dayThreeData)

let slopes = [
    (1, 1),
    (3, 1),
    (5, 1),
    (7, 1),
    (1, 2)
]

let day3Solution1 = navigator.treesEncountered(.init(over: slopes[1].0, down: slopes[1].1))
let day3Solution2 = slopes.map({ navigator.treesEncountered(.init(over: $0.0, down: $0.1)) }).reduce(1, *)

SolutionOutputHandler.writeOutput(challengeName: "Day 3: Toboggan Trajectory", firstSolution: day3Solution1, secondSolution: day3Solution2)

// MARK: Day 4

let dayFourData = InputFileReader.readInput(id: "Day4", stringSeperator: "\n\n")

var passportValidator = PassportValidator(dayFourData)
let day4Solution1 = passportValidator.countValidPassports()
passportValidator.validationType = .validateRequiredFieldValues
let day4Solution2 = passportValidator.countValidPassports()

SolutionOutputHandler.writeOutput(challengeName: "Day 4: Passport Processing", firstSolution: day4Solution1, secondSolution: day4Solution2)

// MARK: Day 5

let dayFiveData = InputFileReader.readInput(id: "Day5")

let boardingPassHandler = BoardingPassHandler(dayFiveData)
if  let day5Solution1 = boardingPassHandler.highestSeatID,
    let day5Solution2 = boardingPassHandler.mySeatID {

    SolutionOutputHandler.writeOutput(challengeName: "Day 5: Binary Boarding", firstSolution: day5Solution1, secondSolution: day5Solution2)
}

// MARK: Day 6

let daySixData = InputFileReader.readInput(id: "Day6", stringSeperator: "\n\n")

var customsFormsHandler = CustomsFormsHandler(daySixData, validationType: .anyoneInGroupPositive)
let day6Solution1 = customsFormsHandler.customsTotals
customsFormsHandler.validationType = .everyoneInGroupPositive
let day6Solution2 = customsFormsHandler.customsTotals

SolutionOutputHandler.writeOutput(challengeName: "Day 6: Custom Customs", firstSolution: day6Solution1, secondSolution: day6Solution2)

// MARK: Day 7

let daySevenData = InputFileReader.readInput(id: "Day7")

let bagHandler = BagHandler(daySevenData)
let day7Solution1 = bagHandler.possibleBags(for: "shiny gold").count
let day7Solution2 = bagHandler.bagContainsCount(by: "shiny gold")

SolutionOutputHandler.writeOutput(challengeName: "Day 7: Handy Haversacks", firstSolution: day7Solution1, secondSolution: day7Solution2)


// MARK: Day 8

let dayEightData = InputFileReader.readInput(id: "Day8")

let instructionHandler = InstructionHandler(dayEightData)
let day8Solution1 = instructionHandler.accumulatedTotal().value
let day8Solution2 = instructionHandler.completedTotal

SolutionOutputHandler.writeOutput(challengeName: "Day 8: Handheld Halting", firstSolution: day8Solution1, secondSolution: day8Solution2)

// MARK: Day 9

let dayNineData = InputFileReader.readInput(id: "Day9")

let cypherHandler = CypherHandler(dayNineData)
let day9Solution1 = cypherHandler.cypherNonSum(withPreamble: 25)
let day9Solution2 = cypherHandler.cypherWeakness(withPreamble: 25)

SolutionOutputHandler.writeOutput(challengeName: "Day 9: Encoding Error", firstSolution: day9Solution1, secondSolution: day9Solution2)

// MARK: Day 10

let dayTenData = InputFileReader.readInput(id: "Day10")

let adapterHandler = AdapterHandler(dayTenData)
let day10Solution1 = adapterHandler.adapterProduct
let day10Solution2 = adapterHandler.adapterPossibilities

SolutionOutputHandler.writeOutput(challengeName: "Day 10: Adapter Array", firstSolution: day10Solution1, secondSolution: day10Solution2)

// MARK: Day 11

let dayElevenData = InputFileReader.readInput(id: "Day11")

var seatHandler = SeatHandler(dayElevenData, seatingPreference: .adjacent)
seatHandler.processRules()
let day11Solution1 = seatHandler.occupiedSeats

seatHandler = SeatHandler(dayElevenData, seatingPreference: .visible)
seatHandler.processRules()
let day11Solution2 = seatHandler.occupiedSeats

SolutionOutputHandler.writeOutput(challengeName: "Day 11: Seating System", firstSolution: day11Solution1, secondSolution: day11Solution2)
