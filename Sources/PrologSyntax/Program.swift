import ParserCombinators

/// A Prolog program, representing a
/// "database" of knowledge (more formally:
/// relations).
public struct Program: List, Hashable {
    public let rules: [Rule]
    
    public static let parser = sep(
        alt(
            trim(Rule.parser),
            try! regex("%.*")
        ),
        by: newlines()
    ).map { Program(rules: $0.values.compactMap { $0.asLeft }) }
    
    public init(rules: [Rule]) {
        self.rules = rules
    }
    
    public static func from(_ rules: [Rule]) -> Program {
        return Program(rules: rules)
    }
}
