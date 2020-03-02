public enum SimpleAlt<L, R>: Alt {
    case left(L)
    case right(R)

    public typealias Left = L
    public typealias Right = R
    
    public var asLeft: L? {
        switch self {
            case .left(let l): return l
            default: return nil
        }
    }
    
    public var asRight: R? {
        switch self {
            case .right(let r): return r
            default: return nil
        }
    }
    
    public static func from(left: L) -> SimpleAlt<L, R> {
        return .left(left)
    }
    
    public static func from(right: R) -> SimpleAlt<L, R> {
        return .right(right)
    }
}

extension SimpleAlt: Equatable where L: Equatable, R: Equatable {}
