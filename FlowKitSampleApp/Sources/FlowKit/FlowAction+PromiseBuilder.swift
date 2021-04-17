extension FlowAction: FlowNode {
    public func makeAction(with: Void) -> FlowAction<Value> {
        return self
    }
}
