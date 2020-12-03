import Foundation

public class InputFileReader {
    public static func readInput(id: String, separator: Character = "\n") -> [String] {
        guard let url = Bundle.main.url(forResource:"\(id)", withExtension: nil),
              let fileContents = try? String(contentsOf: url, encoding: .utf8)
        else {
            fatalError("Can not get file")
        }

        let input = fileContents.split(separator: separator).map(String.init)
        return input
    }
}
