public func firstly<Node: FlowNode>(_ node: Node) -> FlowAction<Node.Output> where Node.Input == Void {
    return node.makeAction()
}
