public protocol OptionalFlowNode {
    associatedtype Input
    associatedtype Output

    func optionalAction(with: Input) -> FlowAction<Output?>
}
