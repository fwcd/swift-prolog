/// A parser combinator.
public protocol Parser {
    associatedtype Value
    
    /// Tries to parse a value from the given string.
    /// The resulting tuple contains the parsed value
    /// (if successful) and the remaining (unprocessed)
    /// string.
    func parse(from raw: String) -> (Value, String)?
}

public extension Parser {
    /// Convenience method for only parsing a value
    /// and making sure the whole string is consumed.
    func parseValue(from raw: String) -> Value? {
        return parse(from: raw).flatMap { (v, s) in s.isEmpty ? v : nil }
    }
}
