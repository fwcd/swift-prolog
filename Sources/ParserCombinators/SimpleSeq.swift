public struct SimpleSeq<L, R>: Seq {
    public let left: L
    public let right: R
    
    public static func from(_ left: L, _ right: R) -> SimpleSeq<L, R> {
        return SimpleSeq(left: left, right: right)
    }
}

extension SimpleSeq: Equatable where L: Equatable, R: Equatable {}
