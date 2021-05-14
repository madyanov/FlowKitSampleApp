extension FlowAction {
    public func then<Node: FlowNode>(_ node: Node) -> FlowAction<Node.Output> where Node.Input == Output {
        return privateThen(node)
    }

    public func then<Node: FlowNode>(_ node: Node) -> FlowAction<Node.Output> where Node.Input == Void {
        return void().privateThen(node)
    }

    public func then<Node: FlowNode>(_ node: Node) -> FlowAction<Node.Output> where Output == Void, Node.Input == Void {
        return void().privateThen(node)
    }

    public func then<NewOutput>(_ builder: @escaping (FlowAction<Output>) -> FlowAction<NewOutput>)
        -> FlowAction<NewOutput> {

        return privateThen(InlineFlowNode(builder: builder))
    }

    public func then<NewOutput>(_ builder: @escaping (FlowAction<Void>) -> FlowAction<NewOutput>)
        -> FlowAction<NewOutput> {

        return void().privateThen(InlineFlowNode(builder: builder))
    }

    public func then(_ builder: @escaping (FlowAction<Void>) -> FlowAction<Void>) -> FlowAction<Void> {
        return void().privateThen(InlineFlowNode(builder: builder))
    }
}

private extension FlowAction {
    private func privateThen<Node: FlowNode>(_ node: Node) -> FlowAction<Node.Output> where Node.Input == Output {
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
}
