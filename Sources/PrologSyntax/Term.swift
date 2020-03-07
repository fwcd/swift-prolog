import ParserCombinators

/// A term is a Prolog expression.
public enum Term: Alt, Hashable {
    case variable(String)
    case combinator(String, [Term])
    
    public static let parser = recursive { alt(
        try! regex("[A-Z]+"),
        seq(
            try! regex("[a-z]+"),
            seqCenter(
                trim(const("(")),
                sep($0, by: trim(const(","))),
                trim(const(")"))
            )
        ),
        as: Term.self
    ) }
    
    public static func from(left: String) -> Term {
        return .variable(left)
    }

    public static func from(right: SimpleSeq<String, SimpleList<Term>>) -> Term {
        return .combinator(right.left, right.right.values)
    }
}
