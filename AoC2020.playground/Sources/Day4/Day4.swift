import Foundation

public struct PassportValidator {
    
    public enum ValidationType {
        case requiredFieldsPresent
        case validateRequiredFieldValues
    }

    public let passports: [String]
    public let validationType: ValidationType = .requiredFieldsPresent

    public init(passportData: [String]) {
        self.passports = passportData.compactMap({ $0.replacingOccurrences(of: "\n", with: "") })
    }

    let requiredFields = [
        "byr": validBYR,
        "iyr": validIYR,
        "eyr": validEYR,
        "hgt": validHGT,
        "hcl": validHCL,
        "ecl": validECL,
        "pid": validPID]

    let optionalFields = ["cid"]

    public func isValid(passportEntry: String) -> Bool {
        // Since it looks like jSON - let's treat it like such.
        let scanner = Scanner(string: passportEntry)
        var fieldsAndValues: [String: String] = [:]

        while true {
            guard let field = scanner.scanUpToString(":") else {
                break
            }
            guard scanner.scanString(":") != nil else {
                break
            }
            guard let value = scanner.scanUpToCharacters(from: .whitespaces) else {
                break
            }

            fieldsAndValues[field] = value
        }

        // If one of the required fields is missing, then it is an invalid passport.
        let invalidPassportFields = requiredFields.filter { field, rule in
            guard let value = fieldsAndValues[field] else {
                return true // Missing
            }

            switch validationType {
            case .requiredFieldsPresent:
                return false
            case .validateRequiredFieldValues:
                return !rule(value)
            }
        }

        return invalidPassportFields.isEmpty
    }

    public func countValidPassports(with validationType: ValidationType) -> Int {
        return passports.filter({ isValid(passportEntry: $0) }).count
    }
}

func validBYR(_ string: String) -> Bool {

    guard let year = Int(string) else {
        return false
    }

    return (1920...2002).contains(year)
}

func validIYR(_ string: String) -> Bool {

    guard let year = Int(string) else {
        return false
    }

    return (2010...2020).contains(year)
}

func validEYR(_ string: String) -> Bool {

    guard let year = Int(string) else {
        return false
    }

    return (2020...2030).contains(year)
}

func validHGT(_ string: String) -> Bool {

    let scanner = Scanner(string: string)
    guard let height = scanner.scanInt() else {
        return false
    }
    guard let unit = scanner.scanCharacters(from: .letters) else {
        return false
    }

    if unit == "cm" {
        return (150...193).contains(height)
    } else if unit == "in" {
        return (59...76).contains(height)
    } else {
        return false
    }
}

func validHCL(_ string: String) -> Bool {

    let scanner = Scanner(string: string)
    guard scanner.scanCharacter() == "#" else {
        return false
    }
    guard let hex = scanner.scanCharacters(from: .alphanumerics) else {
        return false
    }

    return hex.count == 6
}

func validECL(_ string: String) -> Bool {

    return ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"].contains(string)

}

func validPID(_ string: String) -> Bool {

    let scanner = Scanner(string: string)
    guard let identifier = scanner.scanCharacters(from: .decimalDigits) else {
        return false
    }
    return identifier.count == 9
}
