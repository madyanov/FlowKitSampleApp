extension Promise: Finalizable {
    public func complete(with completion: @escaping (Result<Value, Error>) -> Void) {
        work { completion($0) }
    }

    public func finally<Builder: VoidPromiseBuilder>(_ builder: Builder) {
        complete { _ in builder.build().execute() }
    }

    public func execute() {
        complete { _ in }
    }
}
