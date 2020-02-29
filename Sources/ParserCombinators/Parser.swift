/// A parser combinator.
public protocol Parser {
    associatedtype Value
    
    /// Tries to parse a value from the given string.
    /// The resulting tuple contains the parsed value
    /// (if successful) and the remaining (unprocessed)
    /// string.
    func parse(from raw: String) -> (Value, String)?
    
    /// Convenience method for only parsing the value.
    func parseValue(from raw: String) -> Value?
}

public extension Parser {
    func parseValue(from raw: String) -> Value? {
        return parse(from: raw).map { (v, _) in v }
    }
}
