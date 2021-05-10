public struct Finalizer<Output> {
    private let action: FlowAction<Output>

    init(action: FlowAction<Output>) {
        self.action = action
    }
}

extension Finalizer: Finalizable {
    public func finally<Node: FlowNode>(_ node: Node) where Node.Input == Void {
        return action.finally(node)
    }

    public func complete(using completion: @escaping FlowAction<Output>.Completion) {
        action.complete(using: completion)
    }

    public func complete() {
        action.complete()
    }
}
