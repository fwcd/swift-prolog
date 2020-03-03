public struct SimpleRep<T>: Rep {
    public let values: [T]
    
    public static func from(_ values: [T]) -> SimpleRep<T> {
        return SimpleRep(values: values)
    }
}
