public protocol ValueTransformer: OptionalValueTransformer {
    func map(input: Input) -> Output
}

extension ValueTransformer {
    public func compactMap(input: Input) -> Output? {
        return map(input: input)
    }
}
