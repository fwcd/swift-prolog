import ParserCombinators

/// A Prolog program, representing a
/// "database" of knowledge (more formally:
/// relations).
public struct Program: List {
    public let rules: [Rule]
    
    public static func from(_ rules: [Rule]) -> Program {
        return Program(rules: rules)
    }
}
