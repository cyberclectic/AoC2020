public struct ShuttleHandler {
    var estimatedTimestamp: Int
    var input: [String]

    struct BusOffset {
        var busID: Int
        var offset: Int
    }

   public init(_ input: [String]) {

        guard let estimatedTimestampString = input.first,
              let estimatedTimestamp = Int(estimatedTimestampString) else {
            fatalError()
        }

        self.estimatedTimestamp = estimatedTimestamp
        self.input = input
    }

    public var earliestBusProduct: Int {
        let busIDs = input.last?.components(separatedBy: ",").compactMap({ $0 }).filter({ $0 != "x" }).compactMap({ Int($0) })
        let busOffsets = busIDs?.compactMap({ BusOffset(busID: $0, offset: $0 - (estimatedTimestamp % $0)) })

        let closestBusID = busOffsets?.min { $0.offset < $1.offset }

        guard let busID = closestBusID else {
            fatalError()
        }

        return (busID.busID * busID.offset)
    }

    public var earliestSynchronizedDeparture: Int {

        guard let busIDs = input.last?.components(separatedBy: ",").map({ Int($0) }) else {
            fatalError()
        }

        let busIDsByIndex = busIDs.enumerated().reduce(into: [Int: Int]()) {
            guard let busID = $1.1 else {
                return
            }

            $0[$1.0] = busID
        }

        var timestamp = busIDsByIndex[0]!

        repeat {
            let matched = matchedTimestampBusIDs(for: timestamp, with: busIDsByIndex)
            if matched.count == busIDsByIndex.count {
                break
            }
            timestamp += matched.reduce(1, *)
        } while true

        return timestamp
    }

    func matchedTimestampBusIDs(for timestamp: Int, with busIDsByIndex: [Int: Int]) -> [Int] {

        var result: [Int] = []

        for (index, busID) in busIDsByIndex where (timestamp + index) % busID == 0 {
            result.append(busID)
        }

        return result
    }
}
