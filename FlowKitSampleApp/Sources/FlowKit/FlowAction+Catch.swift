extension FlowAction {
    public func `catch`(_ completion: @escaping (Error) -> AnyFlowNode<Void, Void>?) -> Finalizer<Output> {
        let action = FlowAction { finally in
            complete {
                switch $0 {
                case .success(let output):
                    finally(.success(output))
                case .failure(let error):
                    if let node = completion(error) {
                        node.action(with: ()).complete { _ in finally(.failure(error)) }
                    } else {
                        finally(.failure(error))
                    }
                }
            }
        }

        return Finalizer(action: action)
    }
}
