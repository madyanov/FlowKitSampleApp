extension FlowAction: FlowNode {
    public func makeAction(with: Void) -> FlowAction<Output> {
        return self
    }
}
