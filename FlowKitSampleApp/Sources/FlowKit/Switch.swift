public final class Switch<Input, Value, Output> {
    private let source: FlowAction<Input>
    private let input: Input
    private let value: Value

    private var action: FlowAction<Output>?

    init(source: FlowAction<Input>, input: Input, value: Value) {
        self.source = source
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

    public func when(_ predicate: (Value) -> Bool, then: (FlowAction<Input>) -> FlowAction<Output>) -> Self {
        guard action == nil, predicate(value) else { return self }
        action = then(source)
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

    public func `default`(_ node: (FlowAction<Input>) -> FlowAction<Output>) -> FlowAction<Output> {
        return action ?? node(source)
    }
}
