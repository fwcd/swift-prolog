/// Parses a constant literal.
public struct ConstParser: Parser {
    private let value: String
    
    init(value: String) {
        self.value = value
    }
    
    public func parse(from raw: String) -> (String, String)? {
        guard raw.starts(with: value) else { return nil }
        return (value, String(raw.dropFirst(value.count)))
    }
}
