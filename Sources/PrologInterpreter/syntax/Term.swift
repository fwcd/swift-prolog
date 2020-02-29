public enum Term {
    case variable(String)
    case combinator(String, [Term])
}
