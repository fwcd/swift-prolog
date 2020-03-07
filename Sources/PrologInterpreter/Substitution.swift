import PrologSyntax

/// A substitution table of variable names to terms.
public struct Substitution {
    private let mappings: [String: Term]
    
    public init(_ mappings: [String: Term]) {
        self.mappings = mappings
    }
    
    public init(_ name: String, to term: Term) {
        mappings = [name: term]
    }
    
    /// Applies the substitution to the given term and returns the result.
    public func applied(to term: Term) -> Term {
        return mappings.reduce(term) { (res, m) in res.substituted(m.0, by: m.1) }
    }
}
