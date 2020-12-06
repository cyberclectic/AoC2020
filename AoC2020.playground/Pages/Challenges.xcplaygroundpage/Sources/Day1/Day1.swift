import Foundation

public struct ExpenseReport {
    let lineItems: [Int]

    public init(_ lineItems: [Int]) {
        self.lineItems = lineItems
    }

    public func findProduct(sum: Int, lineItemCount: Int) -> Int? {
        guard lineItemCount > 0 else {
            return nil
        }

        guard let values = findValues(from: 0, sum: sum, lineItemCount: lineItemCount) else {
            return nil
        }

        return values.reduce(1, *)
    }

    func findValues(from startIndex: Int, sum: Int, lineItemCount: Int) -> [Int]? {
        // If no more items to find and sum is zero, then the caller must have found a valid sequence.
        guard lineItemCount > 0 else {
            return sum == 0 ? [] : nil
        }

        //  Recursively iterate the remaining items with one fewer items and a sum decreased by the value. Once this returns non-nil, we have found the entries that sum to the desired total.
        for (idx, value) in lineItems[startIndex...].enumerated() {
            if let values = findValues(from: idx + 1, sum: sum - value, lineItemCount: lineItemCount - 1) {
                return values + [value]
            }
        }

        return nil
    }
}
