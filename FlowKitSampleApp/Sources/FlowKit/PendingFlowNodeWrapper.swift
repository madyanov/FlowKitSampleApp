final class PendingFlowNodeWrapper<Node: FlowNode> {
    private let node: Node
    private var pending = true

    init(_ node: Node) {
        self.node = node
    }

    func complete(with input: Node.Input, completion: @escaping FlowAction<Node.Output>.Completion) {
        guard pending else { return }
        pending = false

        node.action(with: input).complete { [weak self] in
            self?.pending = true
            completion($0)
        }
    }
}
