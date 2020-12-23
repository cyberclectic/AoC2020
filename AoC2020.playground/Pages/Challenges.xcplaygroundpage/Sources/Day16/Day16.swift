public struct TicketHandler {
    var rules: [Rule]
    var myTicket: [Int]
    var nearbyTickets: [[Int]]

    public init(_ input: [String]) {
        var rules: [Rule] = []
        var myTicket: [Int] = []
        var nearbyTickets: [[Int]] = [[]]

        // Input should be in the form of groups of data separated by "\n\n".
        for group in input {
            let lines = group.components(separatedBy: .newlines)

            switch lines.first {
            case "your ticket:":
                myTicket = lines.dropFirst().first?.components(separatedBy: ",").compactMap { Int($0) } ?? []
            case "nearby tickets:":
                nearbyTickets = lines.dropFirst().map { line in
                    return line.components(separatedBy: ",").compactMap { Int($0) }
                }.filter { !$0.isEmpty }
            default:
                rules = lines.map { Rule(from: $0) }
            }
        }

        self.myTicket = myTicket
        self.nearbyTickets = nearbyTickets
        self.rules = rules
    }

    // Part 1: What is your ticket scanning error rate?
    public var ticketScanningErrorRate: Int {
        return nearbyTickets.reduce(0) { sum, ticket in
            // Remove ticket fields that have invalid fields.
            var invalidFields = Set<Int>(ticket)
            rules.forEach { rule in
                rule.validFields(for: ticket).forEach { invalidFields.remove($0) }
            }
            return sum + invalidFields.reduce(0, +)
        }
    }
}
