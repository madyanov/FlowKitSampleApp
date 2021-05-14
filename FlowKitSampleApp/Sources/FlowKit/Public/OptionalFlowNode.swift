public protocol OptionalFlowNode {
    associatedtype Input
    associatedtype Output

    func action(with: Input) -> FlowAction<Output?>
}
