extension FlowAction {
    public func `switch`<NewOutput,
                         Node: FlowNode,
                         Transformer: ValueTransformer>(_ node: Node,
                                                        transform: Transformer,
                                                        builder: @escaping (Switch<Transformer.Output, Node.Output, NewOutput>)
                                                            -> FlowAction<NewOutput>)
        -> FlowAction<NewOutput> where Node.Input == Output, Transformer.Input == Output {

        let wrapper = PendingFlowNodeWrapper(node)

        return FlowAction<NewOutput> { completion in
            complete {
                switch $0 {
                case .success(let input):
                    wrapper.complete(with: input) {
                        switch $0 {
                        case .success(let value):
                            let transformed = transform.map(input: input)
                            builder(Switch(input: transformed, value: value)).complete(using: completion)
                        case .failure(let error):
                            completion(.failure(error))
                        }
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }

    public func `switch`<NewOutput, Node: FlowNode>(_ node: Node,
                                                    builder: @escaping (Switch<Output, Node.Output, NewOutput>)
                                                        -> FlowAction<NewOutput>)
        -> FlowAction<NewOutput> where Node.Input == Output {

        return `switch`(node, transform: PassthroughTransformer<Output>(), builder: builder)
    }

    public func `switch`<NewOutput>(_ builder: @escaping (Switch<Output, Output, NewOutput>) -> FlowAction<NewOutput>)
        -> FlowAction<NewOutput> {

        return FlowAction<NewOutput> { completion in
            complete {
                switch $0 {
                case .success(let value):
                    builder(Switch(input: value, value: value)).complete(using: completion)
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}
