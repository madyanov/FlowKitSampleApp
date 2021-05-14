public final class CancellableFlowNode<Node: FlowNode>: FlowNode {
    public typealias Input = Node.Input
    public typealias Output = Node.Output

    private let node: Node
    private let contextProvider: ContextProvider

    public init(_ node: Node, contextProvider: ContextProvider) {
        self.node = node
        self.contextProvider = contextProvider
    }

    public func action(with input: Input) -> FlowAction<Output> {
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
