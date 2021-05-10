struct InlineFlowNode<Input, Output> {
    private let transform: (FlowAction<Input>) -> FlowAction<Output>

    init(transform: @escaping (FlowAction<Input>) -> FlowAction<Output>) {
        self.transform = transform
    }
}

extension InlineFlowNode: FlowNode {
    func action(with input: Input) -> FlowAction<Output> {
        return transform(initialize(with: input))
    }
}
