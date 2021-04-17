struct InlineFlowNode<Input, Output> {
    private let node: (FlowAction<Input>) -> FlowAction<Output>

    init(_ node: @escaping (FlowAction<Input>) -> FlowAction<Output>) {
        self.node = node
    }
}

extension InlineFlowNode: FlowNode {
    func makeAction(with input: Input) -> FlowAction<Output> {
        return node(FlowAction<Input> { $0(.success(input)) })
    }
}
