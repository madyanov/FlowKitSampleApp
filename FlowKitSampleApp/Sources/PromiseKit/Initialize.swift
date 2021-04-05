public func initialize<Value>(with value: Value) -> Promise<Value> {
    return Promise<Value> { $0(.success(value)) }
}
