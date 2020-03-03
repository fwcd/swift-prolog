/// A term is a Prolog expression.
public enum Term {
    case variable(String)
    case combinator(String, [Term])
}
