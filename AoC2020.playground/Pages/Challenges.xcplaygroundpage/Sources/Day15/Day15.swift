public struct NumberSpeaker {

    var input: [String]

    public init(_ input: [String]) {

        self.input = input
    }

    public func getNumberSpoken(at index: Int) -> Int {
            let numbers = input[0].components(separatedBy: ",").map { Int($0)! }
            var turns: [Int: Int] = [:]

            var i = 1
            var currentNumber = 0
            repeat {
                if numbers.indices.contains(i - 1) {
                    let newNumber = numbers[i - 1]
                    turns[newNumber] = i
                    currentNumber = newNumber
                } else {
                    let lastRound = turns[currentNumber]
                    var newNumber = 0

                    if let lastRound = lastRound {
                        newNumber = i - 1 - lastRound
                    }

                    turns[currentNumber] = i - 1
                    currentNumber = newNumber
                }
                i += 1
            } while i <= index

         return currentNumber
        }

}
