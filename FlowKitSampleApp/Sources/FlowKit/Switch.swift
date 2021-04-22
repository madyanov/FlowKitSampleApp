public final class Switch<Input, Value, Output> {
    private let input: Input
    private let value: Value

    private var action: FlowAction<Output>?

    init(input: Input, value: Value) {
        self.input = input
        self.value = value
    }

    public func when<Node: FlowNode>(_ predicate: (Value) -> Bool, then: Node) -> Self
        where Node.Input == Input, Node.Output == Output {

        guard action == nil, predicate(value) else { return self }
        action = then.makeAction(with: input)
        return self
    }

    public func when<Node: FlowNode>(_ predicate: (Value) -> Bool, then: Node) -> Self
        where Node.Input == Void, Node.Output == Output {

        guard action == nil, predicate(value) else { return self }
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
