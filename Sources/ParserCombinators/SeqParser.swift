/// Parses a sequence/concatenation.
public struct SeqParser<L, R>: Parser where L: Parser, R: Parser {
    private let left: L
    private let right: R
    
    init(left: L, right: R) {
        self.left = left
        self.right = right
    }
    
    public func parse(from raw: String) -> ((L.Value, R.Value), String)? {
        return left.parse(from: raw)
            .flatMap { (l, s1) in right.parse(from: s1).map { (r, s2) in ((l, r), s2) } }
    }
}
