extension FlowNode {
    public func erase() -> AnyFlowNode<Input, Output> {
        return AnyFlowNode(self)
    }
}
