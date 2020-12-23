public struct CustomsFormsHandler {
    public enum FormValidationType {
        case anyoneInGroupPositive
        case everyoneInGroupPositive
    }

    let customsForms: [String]
    public var validationType: FormValidationType

    public init(_ customsForms: [String], validationType: FormValidationType) {
        self.customsForms = customsForms
        self.validationType = validationType
    }

    public var customsTotals: Int {
        switch validationType {
        case .anyoneInGroupPositive:
            // Prepare data.
            let cleanData = customsForms.compactMap({ $0.replacingOccurrences(of: "\n", with: "") })
            return cleanData.reduce(into: 0) { tally, group in
                tally += Set(group.map({ $0 })).count
            }
        case .everyoneInGroupPositive:
            // Prepare Data.
            let cleanData = customsForms.lazy.compactMap({ $0.components(separatedBy: .newlines).filter({ $0 != "" }) })
            return cleanData.reduce(into: 0) { tally, group in
                let firstSet = Set(group[0])
                let otherSets = group.dropFirst().map(Set.init)
                let intersection = otherSets.reduce(into: firstSet) { common, answers in
                    common.formIntersection(answers)
                }
                tally += intersection.count
            }
        }
    }
}
