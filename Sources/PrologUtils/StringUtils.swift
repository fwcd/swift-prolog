extension String {
    public func pluralize(with value: Int) -> String {
        return value == 1 ? self : "\(self)s"
    }
}
