import Foundation
import PrologInterpreter
import PrologSyntax
import PrologUtils

public class PrologREPLHandler {
    private let commandPrefix: String
    private var loadedFilePath: String? = nil
    private var loadedProgram: Program? = nil

    private var commands: [String: (String) throws -> Void]!
    
    public init(commandPrefix: String = ":") {
        self.commandPrefix = commandPrefix
        commands = [
            "q": { _ in throw PrologREPLError.quit },
            "l": { [unowned self] in self.load(filePath: $0) },
            "r": { [unowned self] _ in self.reload() },
            "h": { [unowned self] _ in print("Available commands:\n\(self.commands.keys.map { "\(commandPrefix)\($0)" }.joined(separator: ", "))") }
        ]
    }
    
    /// Handles an invocation.
    public func handle(input: String) throws {
        if input.starts(with: commandPrefix) {
            let invocation = input.dropFirst(commandPrefix.count).split(separator: " ", maxSplits: 2).map { String($0) }
            let rawCommand = invocation[safely: 0] ?? ""
            let rawArgs = invocation[safely: 1] ?? ""
            if let command = commands[rawCommand] {
                try command(rawArgs)
            } else {
                print("Unrecognized command '\(rawCommand)'")
            }
        } else {
            if let parsed = Goal.parser.parseValue(from: input) {
                if let program = loadedProgram {
                    print(SLDTree(resolving: parsed, in: program))
                } else {
                    print("Parsed \(parsed)")
                }
            } else {
                print("Could not parse goal")
            }
        }
    }
    
    /// Loads a Prolog program from the given file path.
    private func load(filePath: String) {
        do {
            guard let rawData = FileManager.default.contents(atPath: filePath) else { throw PrologREPLError.couldNotReadFile }
            guard let raw = String(data: rawData, encoding: .utf8) else { throw PrologREPLError.couldNotDecodeFile }
            guard let program = Program.parser.parseValue(from: raw) else { throw PrologREPLError.couldNotParseFile }

            loadedFilePath = filePath
            loadedProgram = program

            print("Successfully loaded \(program.rules.count) \("rule".pluralized(with: program.rules.count))")
        } catch {
            print("Could not load file: \(error)")
        }
    }
    
    /// Reloads the currently loaded file path.
    private func reload() {
        if let filePath = loadedFilePath {
            load(filePath: filePath)
        } else {
            print("No file loaded yet")
        }
    }
}
