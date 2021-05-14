public protocol OptionalInputTransformer: FlowNode {
    func compactMap(input: Input) -> Output?
}

extension OptionalInputTransformer {
    public func action(with input: Input) -> FlowAction<Output> {
        return FlowAction { completion in
            compactMap(input: input).map { completion(.success($0)) }
        }
    }
}
