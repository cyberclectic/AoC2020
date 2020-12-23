public struct NumberSpeaker {
    var input: [String]

    public init(_ input: [String]) {
        self.input = input
    }

    public func getNumberSpoken(at index: Int) -> Int {
        let numbers = input[0].components(separatedBy: ",").map { Int($0)! }
        var turns: [Int: Int] = [:]

        var counter = 1
        var currentNumber = 0
        repeat {
            if numbers.indices.contains(counter - 1) {
                let newNumber = numbers[counter - 1]
                turns[newNumber] = counter
                currentNumber = newNumber
            } else {
                let lastRound = turns[currentNumber]
                var newNumber = 0

                if let lastRound = lastRound {
                    newNumber = counter - 1 - lastRound
                }

                turns[currentNumber] = counter - 1
                currentNumber = newNumber
            }
            counter += 1
        } while counter <= index

        return currentNumber
    }
}
