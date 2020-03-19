import PrologSyntax

public extension Term {
    /// Finds the first subterm on the right-hand side which does not match with
    /// the corresponding subterm on the left-hand side.
    func disagreementSet(with rhs: Term) -> (Term, Term)? {
        switch self {
            case let .variable(n1):
                switch rhs {
                    case let .variable(n2):
                        return n1 == n2 || n1 == "_" || n2 == "_" ? nil : (self, rhs)
                    case .combinator(_, _):
                        return (self, rhs)
                }
            case let .combinator(n1, ts1):
                switch rhs {
                    case .variable(_):
                        return (self, rhs)
                    case let .combinator(n2, ts2):
                        guard n1 == n2 && ts1.count == ts2.count else { return (self, rhs) }
                        return zip(ts1, ts2).compactMap { $0.0.disagreementSet(with: $0.1) }.first
                }
        }
    }
    
    /// Tries to unify this term with another one.
    func unification(with rhs: Term) -> Substitution? {
        guard let ds = disagreementSet(with: rhs) else { return Substitution.empty }
        let s1: Substitution
        switch ds {
            case (let .variable(n1), let .combinator(n2, ts2)):
                s1 = Substitution(n1, to: .combinator(n2, ts2))
            case (let .combinator(n1, ts1), let .variable(n2)):
                s1 = Substitution(n2, to: .combinator(n1, ts1))
            default:
                return nil
        }
        guard let s2 = s1.applied(to: self).unification(with: s1.applied(to: rhs)) else { return nil }
        return s2.composed(with: s1)
    }
}
