import PrologSyntax
import PrologUtils

public class PrologREPLHandler {
    private var loadedFilePath: String? = nil
    private var loadedProgram: Program? = nil

    private var commands: [String: (String) throws -> Void]!
    
    public init() {
        commands = [
            "q": { _ in throw PrologREPLError.quit },
            "l": { [unowned self] in self.load(filePath: $0) },
            "r": { [unowned self] _ in self.reload() }
        ]
    }
    
    /// Handles an invocation.
    public func handle(input: String) throws {
        if input.starts(with: ":") {
            let invocation = input.dropFirst().split(separator: " ", maxSplits: 2).map { String($0) }
            let rawCommand = invocation[safely: 0] ?? ""
            let rawArgs = invocation[safely: 1] ?? ""
            if let command = commands[rawCommand] {
                try command(rawArgs)
            } else {
                print("Unrecognized command '\(rawCommand)'")
            }
        }
    }
    
    /// Loads a Prolog program from the given file path.
    private func load(filePath: String) {
        
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
