extension FlowAction {
    public func `catch`(_ completion: @escaping (Error) -> VoidFlowNode?) -> Finalizer<Value>  {
        let action = FlowAction { finally in
            complete {
                switch $0 {
                case .success(let value):
                    finally(.success(value))
                case .failure(let error):
                    if let node = completion(error) {
                        node.makeAction().complete { _ in finally(.failure(error)) }
                    } else {
                        finally(.failure(error))
                    }
                }
            }
        }

        return Finalizer(action: action)
    }
}
