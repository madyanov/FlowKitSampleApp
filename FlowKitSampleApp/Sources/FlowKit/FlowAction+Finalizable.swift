extension FlowAction: Finalizable {
    public func complete(using completion: @escaping (Result<Value, Error>) -> Void) {
        work { completion($0) }
    }

    public func finally<Node: FlowNode>(_ node: Node) where Node.Input == Void {
        complete { _ in node.makeAction().execute() }
    }

    public func execute() {
        complete { _ in }
    }
}
