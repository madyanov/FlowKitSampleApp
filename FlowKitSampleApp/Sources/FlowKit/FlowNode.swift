public protocol FlowNode {
    associatedtype Input
    associatedtype Output

    func makeAction(with: Input) -> FlowAction<Output>
}

extension FlowNode where Input == Void {
    public func makeAction() -> FlowAction<Output> {
        return makeAction(with: ())
    }
}
