public protocol PromiseBuilder: VoidPromiseBuilder {
    associatedtype Input
    associatedtype Output

    func build(with: Input) -> Promise<Output>
}

extension PromiseBuilder where Input == Void {
    public func build() -> Promise<Output> {
        return build(with: ())
    }
}

extension PromiseBuilder {
    public func build() -> Promise<Void> {
        assertionFailure("Void promise builder not implemented in \(Self.self)")
        return Promise<Void> { $0(.success(())) }
    }
}
