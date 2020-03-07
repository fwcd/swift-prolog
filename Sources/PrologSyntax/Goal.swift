import ParserCombinators

/// A goal represents a Prolog query and
/// is a conjunction of multiple terms.
public struct Goal: List, Hashable {
    public let terms: [Term]
    
    public static let parser = seqLeft(
        sep(Term.parser, by: trim(const(",")), as: Goal.self),
        trim(const("."))
    )
    
    public init(terms: [Term]) {
        self.terms = terms
    }
    
    public static func from(_ terms: [Term]) -> Goal {
        return Goal(terms: terms)
    }
}
