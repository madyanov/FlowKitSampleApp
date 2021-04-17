public protocol FlowNode: VoidFlowNode {
    associatedtype Input
    associatedtype Output

    func makeAction(with: Input) -> FlowAction<Output>
}

extension FlowNode where Input == Void {
    public func makeAction() -> FlowAction<Output> {
        return makeAction(with: ())
    }
}

extension FlowNode {
    public func makeAction() -> FlowAction<Void> {
        assertionFailure("Void action factory not implemented in \(Self.self)")
        return FlowAction<Void> { $0(.success(())) }
    }
}
