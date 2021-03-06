import PrologSyntax

/// A substitution table of variable names to terms.
public struct Substitution: Equatable, CustomStringConvertible {
    private let mappings: [(String, Term)]
    public var description: String {
        return "{\(mappings.map { (n, t) in "\(n) -> \(t)" }.joined(separator: ", "))}"
    }
    
    public static let empty = Substitution([])
    
    public init(_ mappings: [(String, Term)]) {
        self.mappings = mappings
    }
    
    public init(_ name: String, to term: Term) {
        mappings = [(name, term)]
    }
    
    /// Applies the substitution to the given term and returns the result.
    public func applied(to term: Term) -> Term {
        return mappings.reduce(term) { res, m in res.substituting(m.0, with: m.1) }
    }
    
    /// Applies the substitution to all terms in a goal.
    public func applied(to goal: Goal) -> Goal {
        return Goal(terms: goal.terms.map { applied(to: $0) })
    }
    
    /// Composes two substitutions.
    public func composed(with first: Substitution) -> Substitution {
        let chainedMappings = first.mappings.map { ($0.0, applied(to: $0.1)) }
        let remainingMappings = mappings.filter { m in !first.mappings.contains { m.0 == $0.0 } }
        return Substitution(chainedMappings + remainingMappings)
    }
    
    public static func ==(lhs: Substitution, rhs: Substitution) -> Bool {
        return lhs.mappings.count == rhs.mappings.count
            && zip(lhs.mappings, rhs.mappings)
                .allSatisfy { $0.0.0 == $0.1.0 && $0.0.1 == $0.1.1 }
    }
    
    /// Restricts the substitution's mappings to those contained in the given list of variable names.
    public func restricted(to varNames: [String]) -> Substitution {
        return Substitution(mappings.filter { varNames.contains($0.0) })
    }
}
