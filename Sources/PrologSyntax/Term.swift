import ParserCombinators

/// A term is a Prolog expression.
public enum Term: Alt, Hashable, PrettyStringConvertible {
    case variable(String)
    case combinator(String, [Term])
    
    public var pretty: String {
        switch self {
            case let .variable(name):
                return name
            case let .combinator(name, terms):
                if terms.isEmpty {
                    return name
                } else {
                    return "\(name)(\(terms.map { $0.pretty }.joined(separator: ", ")))"
                }
        }
    }
    
    public static let parser = recursive { alt(
        try! regex("[A-Z]+"),
        seq(
            try! regex("[a-z]+"),
            opt(
                seqCenter(
                    trim(const("(")),
                    sep($0, by: trim(const(","))),
                    trim(const(")"))
                )
            ).map { $0.value?.values ?? [] }
        ),
        as: Term.self
    ) }
    
    public static func from(left: String) -> Term {
        return .variable(left)
    }

    public static func from(right: SimpleSeq<String, [Term]>) -> Term {
        return .combinator(right.left, right.right)
    }
    
    /// Substitutes all occurrences of a variable name in this term by another.
    public func substituting(_ name: String, by term: Term) -> Term {
        switch self {
            case let .variable(varName):
                return name == varName ? term : self
            case let .combinator(name, terms):
                return .combinator(name, terms.map { $0.substituting(name, by: term) })
        }
    }
}
