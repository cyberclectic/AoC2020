import UIKit

// MARK: Day 1

let dayOneData = InputFileReader.readInput(id: "Day1").compactMap({ Int($0) })

let report = ExpenseReport(lineItems: dayOneData)
report.findProduct(sum: 2020, lineItemCount: 2)
report.findProduct(sum: 2020, lineItemCount: 3)

// MARK: Day 2

let dayTwoData = InputFileReader.readInput(id: "Day2")

let passwordValidator = PasswordValidator(passwords: dayTwoData)
passwordValidator.checkPasswords(policy: .count)
passwordValidator.checkPasswords(policy: .location)

// MARK: Day 3

