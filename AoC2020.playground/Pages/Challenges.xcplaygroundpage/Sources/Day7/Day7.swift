import Foundation

public struct BagHandler {
    let bagsByColor: [String: Set<String>]
    let colorsByBag: [String: [String]]

    public init(_ bagData: [String]) {
        var bagsByColor: [String: Set<String>] = [:]
        var colorsByBag: [String: [String]] = [:]

        for line in bagData {
            let components = line.components(separatedBy: " bags contain")
            let bagColor = components[0]
            let rules = components[1].components(separatedBy: ", ")
            var colorsContained: [String] = []

            for clause in rules {
                let scanner = Scanner(string: clause)
                guard let count = scanner.scanInt() else { continue }
                guard let color = scanner.scanUpToString(" bag") else { fatalError("Uh Oh - Couldn't read rule.") }

                bagsByColor[color, default: Set()].insert(bagColor)
                colorsContained += Array(repeating: color, count: count)
            }

            colorsByBag[bagColor] = colorsContained
        }

        self.bagsByColor = bagsByColor
        self.colorsByBag = colorsByBag
    }

    public func possibleBags(for color: String) -> Set<String> {
        let bags = bagsByColor[color] ?? Set()
        return bags.reduce(bags) { $0.union(possibleBags(for: $1)) }
    }

    public func bagContainsCount(by color: String) -> Int {
        let colors = colorsByBag[color] ?? []
        return colors.reduce(colors.count) { $0 + bagContainsCount(by: $1) }
    }
}
