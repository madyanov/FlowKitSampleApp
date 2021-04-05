public struct Finalizer<Value> {
    private let promise: Promise<Value>

    init(promise: Promise<Value>) {
        self.promise = promise
    }
}

extension Finalizer: Finalizable {
    public func complete(using completion: @escaping (Result<Value, Error>) -> Void) {
        promise.complete(using: completion)
    }

    public func finally<Builder>(_ builder: Builder) where Builder : PromiseBuilder, Builder.Input == Void {
        return promise.finally(builder)
    }

    public func execute() {
        promise.execute()
    }
}
