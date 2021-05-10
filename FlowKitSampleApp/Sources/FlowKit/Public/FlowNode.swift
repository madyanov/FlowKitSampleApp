public protocol FlowNode {
    associatedtype Input
    associatedtype Output

    func action(with: Input) -> FlowAction<Output>
}
