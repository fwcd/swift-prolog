/// Parses an alternative to a custom type A.
public struct AltParser<L, R, A>: Parser where L: Parser, R: Parser, A: Alt, L.Value == A.Left, R.Value == A.Right {
    private let left: L
    private let right: R
    
    init(left: L, right: R) {
        self.left = left
        self.right = right
    }
    
    public func parse(from raw: String) -> (A, String)? {
        return left.parse(from: raw).map { (l, s) in (A.from(left: l), s) }
            ?? right.parse(from: raw).map { (r, s) in (A.from(right: r), s) }
    }
}
