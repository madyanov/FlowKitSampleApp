extension Promise {
    public func then<Builder: PromiseBuilder>(_ builder: Builder) -> Promise<Builder.Output>
        where Builder.Input == Value {

        return Promise<Builder.Output> { completion in
            complete {
                switch $0 {
                case .success(let value):
                    builder.build(with: value).complete(using: completion)
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }

    public func then<Builder: PromiseBuilder>(_ builder: Builder) -> Promise<Builder.Output>
        where Builder.Input == Void {

        return Promise<Builder.Output> { completion in
            complete {
                switch $0 {
                case .success:
                    builder.build().complete(using: completion)
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }

    // workaround to solve Void -> Void ambiguity
    public func then<Builder: PromiseBuilder>(_ builder: Builder) -> Promise<Builder.Output>
        where Builder.Input == Void, Value == Void {

        return Promise<Builder.Output> { completion in
            complete {
                switch $0 {
                case .success:
                    builder.build().complete(using: completion)
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }

    public func then<Output>(_ builder: @escaping (Promise<Value>) -> Promise<Output>) -> Promise<Output> {
        return then(InlinePromiseBuilder<Value, Output>(builder))
    }
}
