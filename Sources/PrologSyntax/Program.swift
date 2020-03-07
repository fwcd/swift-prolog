import ParserCombinators

/// A Prolog program, representing a
/// "database" of knowledge (more formally:
/// relations).
public struct Program: List, Hashable {
    public let rules: [Rule]
    
    public init(rules: [Rule]) {
        self.rules = rules
    }
    
    public static func from(_ rules: [Rule]) -> Program {
        return Program(rules: rules)
    }
}
