public enum SimpleAlt<L, R>: Alt {
    case left(L)
    case right(R)
    
    public static func from(left: L) -> SimpleAlt<L, R> {
        return .left(left)
    }
    
    public static func from(right: R) -> SimpleAlt<L, R> {
        return .right(right)
    }
}

extension SimpleAlt: Equatable where L: Equatable, R: Equatable {}
