extension FlowAction {
    public func then<Node: FlowNode>(_ node: Node) -> FlowAction<Node.Output> where Node.Input == Output {
        return FlowAction<Node.Output> { completion in
            complete {
                switch $0 {
                case .success(let output):
                    node.action(with: output).complete(using: completion)
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }

    public func then<Node: FlowNode>(_ node: Node) -> FlowAction<Node.Output> where Node.Input == Void {
        return FlowAction<Node.Output> { completion in
            complete {
                switch $0 {
                case .success:
                    node.action().complete(using: completion)
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }

    // Workaround to solve Void -> Void ambiguity
    public func then<Node: FlowNode>(_ node: Node) -> FlowAction<Node.Output> where Node.Input == Void, Output == Void {
        return FlowAction<Node.Output> { completion in
            complete {
                switch $0 {
                case .success:
                    node.action().complete(using: completion)
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }

    public func then<NewOutput>(_ transform: @escaping (FlowAction<Output>) -> FlowAction<NewOutput>)
        -> FlowAction<NewOutput> {

        return then(InlineFlowNode(transform: transform))
    }
}
