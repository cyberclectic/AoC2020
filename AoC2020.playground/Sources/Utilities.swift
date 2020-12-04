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

    public static func readInput(id: String, stringSeperator: String) -> [String] {
        guard let url = Bundle.main.url(forResource:"\(id)", withExtension: nil),
              let fileContents = try? String(contentsOf: url, encoding: .utf8)
        else {
            fatalError("Can not get file")
        }

        let input = fileContents.components(separatedBy: stringSeperator)
        return input
    }
}

public class SolutionOutputHandler {
    public static func writeOutput(year: Int = 2020, challengeName: String, firstSolution: Int, secondSolution: Int) {

        var firstLine = "Advent of Code \(year): Swift Playground"
        firstLine.center(to: 50, with: " ")
        
        var secondLine = challengeName
        secondLine.center(to: 50, with: " ")

        let firstSolutionLine = "Part 1 solution: \(firstSolution)"
        let secondSolutionLine = "Part 2 solution: \(secondSolution)"

        print()
        print(String(repeating: "-", count: 50))
        print(firstLine)
        print(secondLine)
        print(String(repeating: "-", count: 50))
        print()
        print(firstSolutionLine)
        print(secondSolutionLine)
        print(String(repeating: "<>", count: 25))
        print()
    }
}
