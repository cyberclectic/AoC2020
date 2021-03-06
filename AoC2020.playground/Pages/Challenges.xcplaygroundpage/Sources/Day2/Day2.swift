import Foundation

public struct PasswordValidator {
    let passwords: [String]

    public init(_ passwords: [String]) {
        self.passwords = passwords
    }

    public func checkPasswords(with policy: ParsedPasswordEntry.ValidationRule) -> Int {
        return passwords.reduce(0) { count, line in
            guard ParsedPasswordEntry(string: line)?.validate(policy: policy) == true else {
                return count
            }

            return count + 1
        }
    }
}

public struct ParsedPasswordEntry {
    let positions: (Int, Int)
    let validCharacter: Character
    let password: String

    public enum ValidationRule {
        case count
        case location
    }

    public init?(string: String) {
        let lineScanner = Scanner(string: string)
        guard let firstNumber = lineScanner.scanInt(representation: .decimal),
              lineScanner.scanString("-") != nil,
              let nextNumber = lineScanner.scanInt(representation: .decimal),
              let character = lineScanner.scanCharacter(),
              lineScanner.scanString(":") != nil,
              let password = lineScanner.scanCharacters(from: .alphanumerics) else {
            return nil
        }

        self.positions = (firstNumber, nextNumber)
        self.validCharacter = character
        self.password = password
    }

    public func validate(policy: ValidationRule) -> Bool {
        switch policy {
        case .count:
            let letterCount = password.reduce(0) { $0 + (($1 == validCharacter) ? 1 : 0) }
            return (positions.0...positions.1).contains(letterCount)
        case .location:
            let char1 = passwordCharacter(at: positions.0 - 1)
            let char2 = passwordCharacter(at: positions.1 - 1)
            return (char1 == validCharacter) != (char2 == validCharacter)
        }
    }

    func passwordCharacter(at offset: Int) -> Character {
        return password[password.index(password.startIndex, offsetBy: offset)]
    }
}
