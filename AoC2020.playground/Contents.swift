import Foundation

// MARK: Day 1

let dayOneData = InputFileReader.readInput(id: "Day1").compactMap({ Int($0) })

let report = ExpenseReport(lineItems: dayOneData)

if let day1Solution1 = report.findProduct(sum: 2020, lineItemCount: 2),
   let day1Solution2 = report.findProduct(sum: 2020, lineItemCount: 3) {

    SolutionOutputHandler.writeOutput(challengeName: "Day 1: Report Repair", firstSolution: day1Solution1, secondSolution: day1Solution2)
}

// MARK: Day 2

let dayTwoData = InputFileReader.readInput(id: "Day2")

let passwordValidator = PasswordValidator(passwords: dayTwoData)
let day2Solution1 = passwordValidator.checkPasswords(policy: .count)
let day2Solution2 = passwordValidator.checkPasswords(policy: .location)

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

let day3Solution1 = navigator.treesEncountered(slope: .init(over: slopes[1].0, down: slopes[1].1))
let day3Solution2 = slopes.map({ navigator.treesEncountered(slope: .init(over: $0.0, down: $0.1)) }).reduce(1, *)

SolutionOutputHandler.writeOutput(challengeName: "Day 3: Toboggan Trajectory", firstSolution: day3Solution1, secondSolution: day3Solution2)

// MARK: Day 4

let dayFourData = InputFileReader.readInput(id: "Day4", stringSeperator: "\n\n")

var passportValidator = PassportValidator(passportData: dayFourData)
let day4Solution1 = passportValidator.countValidPassports()
passportValidator.validationType = .validateRequiredFieldValues
let day4Solution2 = passportValidator.countValidPassports()

SolutionOutputHandler.writeOutput(challengeName: "Day 4: Passport Processing", firstSolution: day4Solution1, secondSolution: day4Solution2)
