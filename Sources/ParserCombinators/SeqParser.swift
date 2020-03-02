/// Parses a sequence/concatenation to a custom type S.
public struct SeqParser<L, R, S>: Parser where L: Parser, R: Parser, S: Seq, L.Value == S.Left, R.Value == S.Right {
    private let left: L
    private let right: R
    
    init(left: L, right: R) {
        self.left = left
        self.right = right
    }
    
    public func parse(from raw: String) -> (S, String)? {
        return left.parse(from: raw)
            .flatMap { (l, s1) in right.parse(from: s1).map { (r, s2) in (S.from(l, r), s2) } }
    }
}
