extension FlowAction {
    public func `catch`<Node: FlowNode>(_ completion: @escaping (Error) -> Node?)
        -> Finalizer<Output> where Node.Input == Void {

        let action = FlowAction { finally in
            complete {
                switch $0 {
                case .success(let output):
                    finally(.success(output))
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
