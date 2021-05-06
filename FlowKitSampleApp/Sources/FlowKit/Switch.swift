public final class Switch<Input, Value, Output> {
    private let input: Input
    private let value: Value

    private var action: FlowAction<Output>?

    init(input: Input, value: Value) {
        self.input = input
        self.value = value
    }

    public func when<Transformer: ValueTransformer, Node: FlowNode>(_ transformer: Transformer,
                                                                    then node: Node) -> Self
        where Transformer.Input == Input,
              Transformer.Output == Node.Input,
              Node.Output == Output {

        guard action == nil, let transformed = transformer.transform(input: input) else { return self }
        action = node.action(with: transformed)
        return self
    }

    public func when<Node: FlowNode>(_ predicate: (Value) -> Bool, then: Node) -> Self
        where Node.Input == Input, Node.Output == Output {

        guard action == nil, predicate(value) else { return self }
        action = then.action(with: input)
        return self
    }

    public func when<Node: FlowNode>(_ predicate: (Value) -> Bool, then: Node) -> Self
        where Node.Input == Void, Node.Output == Output {

        guard action == nil, predicate(value) else { return self }
        action = then.action()
        return self
    }

    public func when(_ predicate: (Value) -> Bool, then transform: (FlowAction<Input>) -> FlowAction<Output>) -> Self {
        guard action == nil, predicate(value) else { return self }
        action = transform(initialize(with: input))
        return self
    }

    public func `default`<Node: FlowNode>(_ node: Node) -> FlowAction<Output>
        where Node.Input == Input, Node.Output == Output {

        return action ?? node.action(with: input)
    }

    public func `default`<Node: FlowNode>(_ node: Node) -> FlowAction<Output>
        where Node.Input == Void, Node.Output == Output {

        return action ?? node.action()
    }

    public func `default`(_ transform: (FlowAction<Input>) -> FlowAction<Output>) -> FlowAction<Output> {
        return action ?? transform(initialize(with: input))
    }

    public func `continue`() -> FlowAction<Output> where Output == Input {
        return action ?? initialize(with: input)
    }
}
