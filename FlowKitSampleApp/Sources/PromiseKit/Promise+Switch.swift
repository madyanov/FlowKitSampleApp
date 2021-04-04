extension Promise {
    public func `switch`<Output>(_ switch: @escaping (Switch<Value, Output>) -> Promise<Output>) -> Promise<Output> {
        return Promise<Output> { completion in
            complete {
                switch $0 {
                case .success(let value):
                    `switch`(Switch(input: value)).complete(with: completion)
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}
