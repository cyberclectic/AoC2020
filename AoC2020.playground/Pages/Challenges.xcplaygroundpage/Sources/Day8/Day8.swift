public struct InstructionHandler {

    let instructions: [String]

    public init(_ instructions: [String]) {

        self.instructions = instructions
    }

    public func accumulatedTotal() -> (value: Int, terminated: Bool) {

        let inputs: [Instruction] = instructions.lazy.compactMap({
            let components = $0.components(separatedBy: .whitespaces)
            guard let operation = Instruction.OperationCommand(rawValue: components[0]),
                  let argument = Int(components[1]) else {
                fatalError("Bad line format")
            }

            return Instruction(operation, argument: argument)

        })

        var processed: Set<Int> = []
        var (accumulator, position) = (0, 0)
        while position < inputs.count && processed.insert(position).inserted {
            let instruction = inputs[position]
            switch instruction.operationType {
            case .acc:
                accumulator += instruction.argument
                position += 1
            case .jmp:
                position += instruction.argument
            case .nop:
                position += 1
            }
        }

        return (accumulator, processed.insert(position).inserted)
    }

    public var completedTotal: Int {
        let inputs: [Instruction] = instructions.lazy.compactMap({
            let components = $0.components(separatedBy: .whitespaces)
            guard let operation = Instruction.OperationCommand(rawValue: components[0]),
                  let argument = Int(components[1]) else {
                fatalError("Bad line format")
            }

            return Instruction(operation, argument: argument)

        })

        for (index, instruction) in inputs.enumerated() where instruction.operationType != .acc {
            var correctedInput = inputs
            correctedInput[index].operationType = instruction.operationType == .jmp ? .nop : .jmp
            let mapped = correctedInput.map({ String($0.operationType.rawValue + " " + String($0.argument)) })
            let instructionHandler = InstructionHandler(mapped)
            let (accumulator, terminates) = instructionHandler.accumulatedTotal()

            guard terminates else {
                continue
            }

            return accumulator
        }

        fatalError()
    }

}

public struct Instruction: Hashable {
    enum OperationCommand: String {
        case acc
        case jmp
        case nop
    }

    var operationType: OperationCommand
    var argument: Int

    init(_ operationType: OperationCommand, argument: Int) {

        self.operationType = operationType
        self.argument = argument
    }
}
