public func initialize<Value>(with value: Value) -> FlowAction<Value> {
    return FlowAction { $0(.success(value)) }
}
