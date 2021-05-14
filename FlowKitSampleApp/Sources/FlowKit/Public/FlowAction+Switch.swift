extension FlowAction {
    public func `switch`<NewOutput,
                         Node: FlowNode,
                         Transformer: InputTransformer>(_ node: Node,
                                                        transformer: Transformer,
                                                        builder: @escaping (Switch<Transformer.Output, Node.Output, NewOutput>)
                                                            -> FlowAction<NewOutput>)
        -> FlowAction<NewOutput> where Node.Input == Output, Transformer.Input == Output {

        return FlowAction<NewOutput> { completion in
            complete {
                switch $0 {
                case .success(let output):
                    node.action(with: output).complete {
                        switch $0 {
                        case .success(let value):
                            let transformed = transformer.map(input: output)
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

        return `switch`(node, transformer: PassthroughTransformer<Output>(), builder: builder)
    }

    public func `switch`<NewOutput>(_ builder: @escaping (Switch<Output, Output, NewOutput>) -> FlowAction<NewOutput>)
        -> FlowAction<NewOutput> {

        return FlowAction<NewOutput> { completion in
            complete {
                switch $0 {
                case .success(let output):
                    builder(Switch(input: output, value: output)).complete(using: completion)
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}
