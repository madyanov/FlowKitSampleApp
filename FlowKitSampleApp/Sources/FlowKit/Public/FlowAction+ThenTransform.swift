extension FlowAction {
    public func then<Transformer: OptionalFlowNode,
                     Node: FlowNode>(_ transformer: Transformer, else node: Node) -> FlowAction<Transformer.Output>
        where Transformer.Input == Output, Node.Input == Output {

        return FlowAction<Transformer.Output> { completion in
            complete {
                switch $0 {
                case .success(let output):
                    transform(transformer: transformer,
                              transformerInput: output,
                              node: node,
                              nodeInput: output,
                              completion: completion)
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }

    public func then<Transformer: OptionalFlowNode,
                     Node: FlowNode>(_ transformer: Transformer, else node: Node) -> FlowAction<Transformer.Output>
        where Transformer.Input == Output, Node.Input == Void {

        return FlowAction<Transformer.Output> { completion in
            complete {
                switch $0 {
                case .success(let output):
                    transform(transformer: transformer,
                              transformerInput: output,
                              node: node,
                              nodeInput: (),
                              completion: completion)
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }

    public func then<Transformer: OptionalFlowNode,
                     NewOutput>(_ transformer: Transformer,
                                else builder: @escaping (FlowAction<Output>) -> FlowAction<NewOutput>)
        -> FlowAction<Transformer.Output> where Transformer.Input == Output {

        return then(transformer, else: InlineFlowNode(builder: builder))
    }

    public func then<Transformer: OptionalFlowNode,
                     NewOutput>(_ transformer: Transformer,
                                else builder: @escaping (FlowAction<Void>) -> FlowAction<NewOutput>)
        -> FlowAction<Transformer.Output> where Transformer.Input == Output {

        return then(transformer, else: InlineFlowNode(builder: builder))
    }
}

private extension FlowAction {
    private func transform<Transformer: OptionalFlowNode,
                           Node: FlowNode,
                           NodeInput>(transformer: Transformer,
                                      transformerInput: Output,
                                      node: Node,
                                      nodeInput: NodeInput,
                                      completion: @escaping FlowAction<Transformer.Output>.Completion)
        where Transformer.Input == Output, Node.Input == NodeInput {

        transformer.action(with: transformerInput).complete {
            switch $0 {
            case .success(let transformed):
                if let transformed = transformed {
                    completion(.success(transformed))
                } else {
                    node.action(with: nodeInput).complete()
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
