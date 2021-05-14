struct InlineFlowNode<Input, Output> {
    private let builder: (FlowAction<Input>) -> FlowAction<Output>

    init(builder: @escaping (FlowAction<Input>) -> FlowAction<Output>) {
        self.builder = builder
    }
}

extension InlineFlowNode: FlowNode {
    func action(with input: Input) -> FlowAction<Output> {
        return builder(initialize(with: input))
    }
}
