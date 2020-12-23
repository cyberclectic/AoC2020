public struct AdapterHandler {
    let adapters: [Int]

    public init(_ adapters: [String]) {
        self.adapters = adapters.compactMap({ Int($0) }).sorted()
    }

    public var adapterProduct: Int {
        let allAdapters = [0] + adapters + [adapters.last ?? 0 + 3]
        var oneJoltAdapters = 0, threeJoltAdapters = 0

        for (index, adapter) in allAdapters.enumerated() {
            switch index {
            case 0:
                // We don't need to process the first adapter.
                continue
            case 1...allAdapters.count:
                // Check against the previous adapter.
                guard adapter == (allAdapters[index - 1] + 1) else {
                    threeJoltAdapters += 1
                    continue
                }
                oneJoltAdapters += 1
            default:
                // Shouldn't reach this.
                fatalError()
            }

        }

        return oneJoltAdapters * threeJoltAdapters
    }

    public var adapterPossibilities: Int {
        let allAdapters = adapters + [adapters.last ?? 0 + 3]

        var possibilities = [0: 1]

        for adapter in allAdapters {
            possibilities[adapter] = possibilities[adapter-1, default: 0] + possibilities[adapter-2, default: 0] + possibilities[adapter-3, default: 0]
        }

        guard let lastAdapter = allAdapters.last,
              let possibleAdapters = possibilities[lastAdapter] else {
            fatalError()
        }

        return possibleAdapters
    }
}
