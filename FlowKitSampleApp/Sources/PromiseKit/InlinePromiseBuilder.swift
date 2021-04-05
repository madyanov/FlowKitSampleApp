struct InlinePromiseBuilder<Input, Output> {
    private let builder: (Promise<Input>) -> Promise<Output>

    init(_ builder: @escaping (Promise<Input>) -> Promise<Output>) {
        self.builder = builder
    }
}

extension InlinePromiseBuilder: PromiseBuilder {
    func build(with input: Input) -> Promise<Output> {
        return builder(Promise<Input> { $0(.success(input)) })
    }
}
