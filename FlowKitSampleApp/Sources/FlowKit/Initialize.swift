public func initialize<Value>(with value: Value) -> FlowAction<Value> {
    return FlowAction<Value> { $0(.success(value)) }
}
