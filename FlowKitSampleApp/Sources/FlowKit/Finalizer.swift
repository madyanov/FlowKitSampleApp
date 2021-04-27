public struct Finalizer<Value> {
    private let action: FlowAction<Value>

    init(action: FlowAction<Value>) {
        self.action = action
    }
}

extension Finalizer: Finalizable {
    public func complete(using completion: @escaping (Result<Value, Error>) -> Void) {
        action.complete(using: completion)
    }

    public func finally<Node: FlowNode>(_ node: Node) where Node.Input == Void {
        return action.finally(node)
    }

    public func execute() {
        action.execute()
    }
}
