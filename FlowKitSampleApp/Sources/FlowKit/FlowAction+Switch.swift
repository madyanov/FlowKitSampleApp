extension FlowAction {
    public func `switch`<Output>(_ switch: @escaping (Switch<Value, Output>) -> FlowAction<Output>)
        -> FlowAction<Output> {

        return FlowAction<Output> { completion in
            complete {
                switch $0 {
                case .success(let value):
                    `switch`(Switch(input: value)).complete(using: completion)
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}
