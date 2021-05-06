public struct PassthroughTransformer<Value>: ValueTransformer {
    public typealias Input = Value
    public typealias Output = Value

    public init() { }

    public func map(input: Input) -> Output {
        return input
    }
}
