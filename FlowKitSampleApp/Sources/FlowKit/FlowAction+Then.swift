extension FlowAction {
    public func then<Node: FlowNode>(_ node: Node) -> FlowAction<Node.Output> where Node.Input == Output {
        return FlowAction<Node.Output> { completion in
            complete {
                switch $0 {
                case .success(let output):
                    node.makeAction(with: output).complete(using: completion)
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
                    node.makeAction().complete(using: completion)
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }

    // workaround to solve Void -> Void ambiguity
    public func then<Node: FlowNode>(_ node: Node) -> FlowAction<Node.Output> where Node.Input == Void, Output == Void {
        return FlowAction<Node.Output> { completion in
            complete {
                switch $0 {
                case .success:
                    node.makeAction().complete(using: completion)
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }

    public func then<NewOutput>(_ node: @escaping (FlowAction<Output>) -> FlowAction<NewOutput>)
        -> FlowAction<NewOutput> {

        return then(InlineFlowNode<Output, NewOutput>(node))
    }
}
