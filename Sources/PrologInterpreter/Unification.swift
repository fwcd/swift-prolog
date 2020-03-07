import PrologSyntax

public extension Term {
    /// Finds the first subterm on the right-hand side which does not match with
    /// the corresponding subterm on the left-hand side.
    func disagreementSet(_ rhs: Term) -> (Term, Term)? {
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
                        guard n1 == n2 && ts1.count == ts2.count else { return nil }
                        return zip(ts1, ts2).compactMap { $0.0.disagreementSet($0.1) }.first
                }
        }
    }
}
