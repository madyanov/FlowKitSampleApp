extension FlowNode {
    public func cancellable(contextProvider: ContextProvider) -> CancellableFlowNode<Self> {
        return CancellableFlowNode(self, contextProvider: contextProvider)
    }
}
