public struct CypherHandler {
    let cyphers: [Int]

    public init(_ cypher: [String]) {
        self.cyphers = cypher.compactMap({ Int($0) })
    }

    public func cypherNonSum(withPreamble preambleLength: Int) -> Int {
        // Only process from the preamble length index onward.
        for index in cyphers.indices.dropFirst(preambleLength) {
            // Create a set of values from the current index minus the preamble length to the current index.
            let valuesToCheck = Set(cyphers[(index-preambleLength)...index])

            // Beginning with the first value of the set, calculate the difference and check if the set contains that value.
            // If it does not contain the difference, this is the value we are looking for.
            let firstValid = valuesToCheck.first {
                let remainder = cyphers[index] - $0
                return remainder != $0 && valuesToCheck.contains(remainder)
            }

            guard firstValid == nil else {
                continue
            }

            return cyphers[index]
        }

        fatalError()
    }

    public func cypherWeakness(withPreamble preambleLength: Int) -> Int {
        // First get our target value.
        let targetValue = cypherNonSum(withPreamble: preambleLength)

        // Now, process the cyphers.
        for (index, cypherValue) in cyphers.enumerated() {
            // Setup some variables we will need.
            var smallestValue = cypherValue
            var largestValue = cypherValue
            var sum = cypherValue

            // Check the remaining values in the cyphers from the current index + 1.
            for valueToVerify in cyphers[(index + 1)...] {
                // Get smallest value.
                smallestValue = min(smallestValue, valueToVerify)
                // Get largest value.
                largestValue = max(largestValue, valueToVerify)
                // Add the current value to the total sum.
                sum += valueToVerify
                // If the sum is equal the target value, then return the sum of the smallest and largest value.
                guard sum == targetValue else {
                    continue
                }

                return smallestValue + largestValue
            }
        }

        fatalError()
    }
}
