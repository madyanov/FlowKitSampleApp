public protocol InputTransformer: OptionalInputTransformer {
    func map(input: Input) -> Output
}

extension InputTransformer {
    public func compactMap(input: Input) -> Output? {
        return map(input: input)
    }
}
