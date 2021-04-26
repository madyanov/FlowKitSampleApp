extension FlowAction {
    public func then<Node: FlowNode>(_ node: Node) -> FlowAction<Node.Output> where Node.Input == Value {
        return FlowAction<Node.Output> { completion in
            complete {
                switch $0 {
                case .success(let value):
                    node.makeAction(with: value).complete(using: completion)
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
    public func then<Node: FlowNode>(_ node: Node) -> FlowAction<Node.Output> where Node.Input == Void, Value == Void {
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

    public func then<Output>(_ node: @escaping (FlowAction<Value>) -> FlowAction<Output>) -> FlowAction<Output> {
        return then(InlineFlowNode<Value, Output>(node))
    }
}
