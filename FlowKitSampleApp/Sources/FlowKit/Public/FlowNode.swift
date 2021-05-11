public protocol FlowNode {
    associatedtype Input
    associatedtype Output

    var disposable: Bool { get }

    func action(with: Input) -> FlowAction<Output>
}

extension FlowNode {
    public var disposable: Bool { return false }
}
