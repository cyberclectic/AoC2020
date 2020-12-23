extension TicketHandler {
    var validNearbyTickets: [[Int]] {
        return nearbyTickets.filter { ticket in
            return ticket.allSatisfy { value in
                rules.first(where: { $0.contains(value) }) != nil
            }
        }
    }

    func orderedRuleNames() -> [String] {
        let allPossibleRuleNames = Set(rules.map { $0.ruleName })
        var possibleRuleNamesByIndex: [Set<String>] = []
        let tickets = validNearbyTickets.filter { !$0.isEmpty }

        for ticketIndex in 0..<myTicket.count {
            var possibleRuleNames = allPossibleRuleNames

            for ticket in tickets {
                let possibleRules = rules.filter { $0.contains(ticket[ticketIndex]) }
                possibleRuleNames = possibleRuleNames.intersection(possibleRules.map { $0.ruleName })
            }

            possibleRuleNamesByIndex.append(possibleRuleNames)
        }

        var verifiedRuleNames = Set<String>()
        for possibleRuleNames in possibleRuleNamesByIndex where possibleRuleNames.count == 1 {
            verifiedRuleNames.insert(possibleRuleNames.first!)
        }

        while verifiedRuleNames != allPossibleRuleNames {
            for ruleIndex in 0..<possibleRuleNamesByIndex.count {
                var possibleRuleNames = possibleRuleNamesByIndex[ruleIndex]
                guard possibleRuleNames.count > 1, !verifiedRuleNames.isEmpty else {
                    continue
                }

                verifiedRuleNames.forEach { possibleRuleNames.remove($0) }
                assert(!possibleRuleNames.isEmpty)

                if possibleRuleNames.count == 1 {
                    verifiedRuleNames.insert(possibleRuleNames.first!)
                }

                possibleRuleNamesByIndex[ruleIndex] = possibleRuleNames
            }
        }

        return possibleRuleNamesByIndex.map { $0.first! }
    }

    public var departureProduct: Int {
        var product = 1
        for (ruleIndex, ruleName) in orderedRuleNames().enumerated() where ruleName.starts(with: "departure") {
            product *= myTicket[ruleIndex]
        }
        return product
    }
}
