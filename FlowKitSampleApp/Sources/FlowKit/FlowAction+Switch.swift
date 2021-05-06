extension FlowAction {
    public func `switch`<NewOutput, Node: FlowNode>(_ node: Node,
                                                    switch: @escaping (Switch<Output, Node.Output, NewOutput>) -> FlowAction<NewOutput>)
        -> FlowAction<NewOutput> where Node.Input == Output {

        return FlowAction<NewOutput> { completion in
            complete {
                switch $0 {
                case .success(let input):
                    node.action(with: input).complete {
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

    public func `switch`<NewOutput>(switch: @escaping (Switch<Output, Output, NewOutput>) -> FlowAction<NewOutput>)
        -> FlowAction<NewOutput> {

        return FlowAction<NewOutput> { completion in
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
