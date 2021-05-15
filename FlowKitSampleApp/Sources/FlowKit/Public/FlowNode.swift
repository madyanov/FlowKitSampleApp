public protocol FlowNode: OptionalFlowNode {
    func action(with: Input) -> FlowAction<Output>
}

extension FlowNode {
    public func optionalAction(with input: Input) -> FlowAction<Output?> {
        return FlowAction<Output?> { completion in
            action(with: input).complete { completion($0.map { $0 }) }
        }
    }
}
