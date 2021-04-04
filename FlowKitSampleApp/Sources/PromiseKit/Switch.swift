public final class Switch<Input, Output> {
    private let input: Input
    private var promise: Promise<Output>?

    init(input: Input) {
        self.input = input
    }

    public func when<Builder: PromiseBuilder>(_ predicate: (Input) -> Bool, then: Builder) -> Self
        where Builder.Input == Input, Builder.Output == Output {

        guard promise == nil, predicate(input) else { return self }
        promise = then.build(with: input)
        return self
    }

    public func when<Builder: PromiseBuilder>(_ predicate: (Input) -> Bool, then: Builder) -> Self
        where Builder.Input == Void, Builder.Output == Output {

        guard promise == nil, predicate(input) else { return self }
        promise = then.build()
        return self
    }

    public func `default`<Builder: PromiseBuilder>(_ builder: Builder) -> Promise<Output>
        where Builder.Input == Input, Builder.Output == Output {

        return promise ?? builder.build(with: input)
    }

    public func `default`<Builder: PromiseBuilder>(_ builder: Builder) -> Promise<Output>
        where Builder.Input == Void, Builder.Output == Output {

        return promise ?? builder.build()
    }
}
