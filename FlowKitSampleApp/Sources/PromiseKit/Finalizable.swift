public protocol Finalizable {
    associatedtype Value

    func complete(using: @escaping (Result<Value, Error>) -> Void)
    func finally<Builder: PromiseBuilder>(_: Builder) where Builder.Input == Void
    func execute()
}
