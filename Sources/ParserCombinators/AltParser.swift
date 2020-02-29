/// Parses an alternative.
public struct AltParser<L, R>: Parser where L: Parser, R: Parser, L.Value == R.Value {
    private let left: L
    private let right: R
    
    init(left: L, right: R) {
        self.left = left
        self.right = right
    }
    
    public func parse(from raw: String) -> (L.Value, String)? {
        return left.parse(from: raw) ?? right.parse(from: raw)
    }
}
