public final class CancellableFlowNode<Node: FlowNode>: FlowNode {
    private let node: Node
    private let contextProvider: ContextProvider

    public init(_ node: Node, contextProvider: ContextProvider) {
        self.node = node
        self.contextProvider = contextProvider
    }

    public func action(with input: Node.Input) -> FlowAction<Node.Output> {
        weak var context = contextProvider.context.value

        return FlowAction { [weak self] completion in
            self?.node.action(with: input).complete {
                guard context != nil,
                      context === self?.contextProvider.context.value
                else { return }

                completion($0)
            }
        }
    }
}
