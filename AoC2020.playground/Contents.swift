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

let firstSolution = navigator.treesEncountered(slope: .init(over: slopes[1].0, down: slopes[1].1))
let secondSolution = slopes.map({ navigator.treesEncountered(slope: .init(over: $0.0, down: $0.1)) }).reduce(1, *)

SolutionOutputHandler.writeOutput(challengeName: "Day 3: Toboggan Trajectory", firstSolution: firstSolution, secondSolution: secondSolution)
