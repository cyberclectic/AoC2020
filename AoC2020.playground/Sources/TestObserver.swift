import Foundation
import XCTest

// Test Observer
public class TestObserver: NSObject, XCTestObservation {
    public func testCase(_ testCase: XCTestCase,
                  didFailWithDescription description: String,
                  inFile filePath: String?,
                  atLine lineNumber: Int) {
        assertionFailure("🛑🛑🛑 " + description, line: UInt(lineNumber))
    }
}


