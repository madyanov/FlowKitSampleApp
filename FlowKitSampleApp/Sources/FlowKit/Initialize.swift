public func initialize<Output>(with output: Output) -> FlowAction<Output> {
    return FlowAction { $0(.success(output)) }
}
