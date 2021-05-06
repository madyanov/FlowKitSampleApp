public protocol FlowNode {
    associatedtype Input
    associatedtype Output

    func action(with: Input) -> FlowAction<Output>
}

extension FlowNode where Input == Void {
    public func action() -> FlowAction<Output> {
        return action(with: ())
    }
}
