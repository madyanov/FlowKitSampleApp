extension FlowAction {
    public func then<Node: FlowNode>(_ node: Node) -> FlowAction<Node.Output> where Node.Input == Output {
        let wrapper = PendingFlowNodeWrapper(node)

        return FlowAction<Node.Output> { completion in
            complete {
                switch $0 {
                case .success(let output):
                    wrapper.complete(with: output, completion: completion)
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
