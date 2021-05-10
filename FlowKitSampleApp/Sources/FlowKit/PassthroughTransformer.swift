struct PassthroughTransformer<Value>: ValueTransformer {
    typealias Input = Value
    typealias Output = Value

    func map(input: Input) -> Output {
        return input
    }
}
