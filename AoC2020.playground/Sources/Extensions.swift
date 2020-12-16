import Foundation

public extension String {

    init(withInt int: Int, leadingZeros: Int = 2) {
        self.init(format: "%0\(leadingZeros)d", int)
    }

    func leadingZeros(_ zeros: Int) -> String {
        if let int = Int(self) {
            return String(withInt: int, leadingZeros: zeros)
        }
        print("Warning: \(self) is not an Int")
        return ""
    }

    mutating func center(to length: Int, with char: Character) {
        let lengthOfPadding = (length - self.count) / 2
        guard lengthOfPadding > 0 else { return }

        self = self.padding(toLength: self.count + lengthOfPadding, withPad: String(char), startingAt: 0)
        self = String(String(self.reversed()).padding(toLength: length, withPad: " ", startingAt: 0).reversed())
    }

}

public extension Int {
    func waypointValidator(_ closure: () -> Void) {
        (0..<self).forEach { _ in closure() }
    }
}
