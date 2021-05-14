extension FlowAction: FlowNode {
    public typealias Input = Void

    public func action(with: Void) -> FlowAction<Output> {
        return self
    }
}
