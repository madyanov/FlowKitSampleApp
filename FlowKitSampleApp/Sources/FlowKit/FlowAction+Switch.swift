extension FlowAction {
    public func `switch`<Output, Node: FlowNode>(_ node: Node,
                                                 switch: @escaping (Switch<Value, Node.Output, Output>) -> FlowAction<Output>)
        -> FlowAction<Output> where Node.Input == Value {

        return FlowAction<Output> { completion in
            complete {
                switch $0 {
                case .success(let input):
                    node.makeAction(with: input).complete {
                        switch $0 {
                        case .success(let value):
                            `switch`(Switch(input: input, value: value)).complete(using: completion)
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

    public func `switch`<Output>(switch: @escaping (Switch<Value, Value, Output>) -> FlowAction<Output>)
        -> FlowAction<Output> {

        return FlowAction<Output> { completion in
            complete {
                switch $0 {
                case .success(let value):
                    `switch`(Switch(input: value, value: value)).complete(using: completion)
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}
