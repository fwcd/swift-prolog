import ParserCombinators

/// A rule is the fundamental building
/// block of a Prolog program and represents
/// knowledge. The left-hand side contains the
/// term to be true under the assumption that the
/// terms on the right-hand side are all true.
public struct Rule: Seq, Hashable, PrettyStringConvertible {
    public let lhs: Term
    public let rhs: [Term]
    public var pretty: String {
        if rhs.isEmpty {
            return "\(lhs)."
        } else {
            return "\(lhs) :- \(rhs.map { "\($0)" }.joined(separator: ", "))."
        }
    }
    
    public static let parser = seqLeft(
        seq(
            Term.parser,
            opt(
                seqRight(
                    trim(const(":-")),
                    sep(
                        Term.parser,
                        by: trim(const(","))
                    )
                )
            ).map { $0.value?.values ?? [] },
            as: Rule.self
        ),
        trim(const("."))
    )
    
    public init(lhs: Term, rhs: [Term]) {
        self.lhs = lhs
        self.rhs = rhs
    }
    
    public static func from(_ lhs: Term, _ rhs: [Term]) -> Rule {
        return Rule(lhs: lhs, rhs: rhs)
    }
}
