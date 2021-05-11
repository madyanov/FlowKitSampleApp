public final class DisposableFlowNode<Node: FlowNode>: FlowNode {
    private let node: Node
    private var pending = true

    public init(_ node: Node) {
        self.node = node
    }

    public func action(with input: Node.Input) -> FlowAction<Node.Output> {
        return FlowAction { [weak self] completion in
            guard let self = self else { return }
            guard self.pending else { return }
            self.pending = false

            self.node.action(with: input).complete {
                self.pending = true
                completion($0)
            }
        }
    }
}
