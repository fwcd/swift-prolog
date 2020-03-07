import ParserCombinators

/// A term is a Prolog expression.
public enum Term: Alt, Hashable, CustomStringConvertible {
    case variable(String)
    case combinator(String, [Term])
    
    public var description: String {
        switch self {
            case let .variable(v):
                return v
            case let .combinator(name, terms):
                if terms.isEmpty {
                    return name
                } else {
                    return "\(name)(\(terms.map { "\($0)" }.joined(separator: ", ")))."
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
}
