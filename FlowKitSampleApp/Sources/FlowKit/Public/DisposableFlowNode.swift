public final class DisposableFlowNode<Node: FlowNode>: FlowNode {
    private let node: Node
    private var busy = false

    public init(_ node: Node) {
        self.node = node
    }

    public func action(with input: Node.Input) -> FlowAction<Node.Output> {
        return FlowAction { [weak self] completion in
            guard let self = self else { return }
            guard self.busy == false else { return }
            self.busy = true

            self.node.action(with: input).complete {
                self.busy = false
                completion($0)
            }
        }
    }
}
