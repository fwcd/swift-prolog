extension String {
    public func pluralized(with value: Int) -> String {
        return value == 1 ? self : "\(self)s"
    }
    
    public func indented(by k: Int) -> String {
        return split(separator: "\n").map { "\(String(repeating: " ", count: k))\($0)" }.joined(separator: "\n")
    }
}
