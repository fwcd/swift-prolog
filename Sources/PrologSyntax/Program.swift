import ParserCombinators

/// A Prolog program, representing a
/// "database" of knowledge (more formally:
/// relations).
public struct Program: List, Hashable, PrettyStringConvertible {
    public let rules: [Rule]
    public var pretty: String {
        return rules.map { $0.pretty }.joined(separator: "\n")
    }
    
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
