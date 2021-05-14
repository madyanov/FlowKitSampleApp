public protocol FlowNode: OptionalFlowNode {
    func action(with: Input) -> FlowAction<Output>
}

extension FlowNode {
    public func action(with input: Input) -> FlowAction<Output?> {
        return FlowAction { completion in
            action(with: input).complete {
                switch $0 {
                case .success(let output):
                    completion(.success(output))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}
