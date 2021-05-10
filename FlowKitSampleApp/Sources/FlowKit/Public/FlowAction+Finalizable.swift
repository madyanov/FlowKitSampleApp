extension FlowAction: Finalizable {
    public func finally<Node: FlowNode>(_ node: Node) where Node.Input == Void {
        complete { _ in node.action(with: ()).complete() }
    }

    public func complete(using completion: @escaping Completion) {
        work { completion($0) }
    }

    public func complete() {
        complete { _ in }
    }
}
