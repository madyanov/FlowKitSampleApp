public protocol Finalizable {
    associatedtype Value

    func complete(using: @escaping (Result<Value, Error>) -> Void)
    func finally<Node: FlowNode>(_: Node) where Node.Input == Void
    func execute()
}
