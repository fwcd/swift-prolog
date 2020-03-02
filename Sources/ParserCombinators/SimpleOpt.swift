public struct SimpleOpt<T>: Opt {
    public let value: T?
    
    public static func from(_ value: T?) -> SimpleOpt<T> {
        return SimpleOpt(value: value)
    }
}

extension SimpleOpt: Equatable where T: Equatable {}
