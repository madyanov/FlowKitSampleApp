public protocol Finalizable {
    associatedtype Output

    func finally<Node: FlowNode>(_: Node) where Node.Input == Void
    func complete(using: @escaping FlowAction<Output>.Completion)
    func complete()
}
