public protocol FlowNode: OptionalFlowNode {
    func action(with: Input) -> FlowAction<Output>
}

extension FlowNode {
    public func action(with input: Input) -> FlowAction<Output?> {
        return FlowAction { completion in
            action(with: input).complete(using: completion)
        }
    }
}
