public func initialize<Output>(with output: Output) -> FlowAction<Output> {
    return FlowAction { $0(.success(output)) }
}

public func initialize() -> FlowAction<Void> {
    return FlowAction { $0(.success(())) }
}
