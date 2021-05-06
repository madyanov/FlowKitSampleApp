extension FlowAction: FlowNode {
    public func action(with: Void) -> FlowAction<Output> {
        return self
    }
}
