struct PassthroughTransformer<Value>: InputTransformer {
    typealias Input = Value
    typealias Output = Value

    func map(input: Input) -> Output {
        return input
    }
}
