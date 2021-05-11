extension FlowNode {
    public func disposable() -> DisposableFlowNode<Self> {
        return DisposableFlowNode(self)
    }
}
