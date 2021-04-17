public final class Switch<Input, Output> {
    private let input: Input
    private var action: FlowAction<Output>?

    init(input: Input) {
        self.input = input
    }

    public func when<Node: FlowNode>(_ predicate: (Input) -> Bool, then: Node) -> Self
        where Node.Input == Input, Node.Output == Output {

        guard action == nil, predicate(input) else { return self }
        action = then.makeAction(with: input)
        return self
    }

    public func when<Node: FlowNode>(_ predicate: (Input) -> Bool, then: Node) -> Self
        where Node.Input == Void, Node.Output == Output {

        guard action == nil, predicate(input) else { return self }
        action = then.makeAction()
        return self
    }

    public func `default`<Node: FlowNode>(_ node: Node) -> FlowAction<Output>
        where Node.Input == Input, Node.Output == Output {

        return action ?? node.makeAction(with: input)
    }

    public func `default`<Node: FlowNode>(_ node: Node) -> FlowAction<Output>
        where Node.Input == Void, Node.Output == Output {

        return action ?? node.makeAction()
    }
}
