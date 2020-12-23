public struct MemoryHandler {
    var input: [String]

    public init(_ input: [String]) {
        self.input = input
    }

    public mutating func memoryValuesTotal() -> Int {
        var mask = ""
        var memoryValues: [Int: Int] = [:]

        for line in input {
            if line.starts(with: "mask = ") {
                mask = line.components(separatedBy: " = ")[1]
            } else {
                guard let memoryAddress = Int(line.dropFirst(4).components(separatedBy: "]")[0]),
                      let value = Int(line.components(separatedBy: " = ")[1])
                else {
                    fatalError()
                }
                var correctedValue = String(String(String(value, radix: 2).reversed()).padding(toLength: 36, withPad: "0", startingAt: 0).reversed())

                for (index, maskChar) in mask.enumerated() {
                    let char = correctedValue[correctedValue.index(correctedValue.startIndex, offsetBy: index)]

                    if char != maskChar,
                       maskChar != "X" {
                        let newValue = correctedValue.prefix(index) + String(maskChar) + correctedValue.dropFirst(index + 1 )
                        correctedValue = String(newValue)
                    }
                }

                memoryValues[memoryAddress] = Int(correctedValue, radix: 2) ?? 0
            }
        }

        return memoryValues.values.reduce(0, +)
    }

    public mutating func memoryValuesTotalV2() -> Int {
        var mask = ""
        var memoryValues: [Int: Int] = [:]

        for line in input {
            if line.starts(with: "mask") {
                mask = line.components(separatedBy: " = ")[1]
            } else {
                guard let memoryAddress = Int(line.dropFirst(4).components(separatedBy: "]")[0]),
                      let value = Int(line.components(separatedBy: " = ")[1])
                else {
                    fatalError()
                }

                let addressBin = String(String(String(memoryAddress, radix: 2).reversed()).padding(toLength: 36, withPad: "0", startingAt: 0).reversed())

                var addressBinChars = Array(addressBin)

                for (index, char) in mask.enumerated() {
                    if char == "0" {
                        continue
                    }

                    addressBinChars[index] = char
                }

                let addresses = processAddressBinary(String(addressBinChars))

                _ = addresses.map { memoryValues[Int($0, radix: 2)!] = value }
            }
        }

        return memoryValues.values.reduce(0, +)
    }

    func processAddressBinary(_ addressBinary: String) -> [String] {
        if !addressBinary.contains("X") {
            return [addressBinary]
        } else {
            let indexOfX = addressBinary.firstIndex(of: "X")!
            let firstAddress = addressBinary.replacingOccurrences(of: "X", with: "0", range: indexOfX ..< addressBinary.index(indexOfX, offsetBy: 1))
            let secondAddress = addressBinary.replacingOccurrences(of: "X", with: "1", range: indexOfX ..< addressBinary.index(indexOfX, offsetBy: 1))

            return processAddressBinary(firstAddress) + processAddressBinary(secondAddress)
        }
    }
}
