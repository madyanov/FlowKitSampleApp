public protocol OptionalInputTransformer: FlowNode {
    func compactMap(input: Input) -> Output?
}

extension OptionalInputTransformer {
    public func action(with input: Input) -> FlowAction<Output> {
        return FlowAction { completion in
            compactMap(input: input).map { completion(.success($0)) }
        }
    }

    public func optionalAction(with input: Input) -> FlowAction<Output?> {
        return FlowAction { completion in
            completion(.success(compactMap(input: input)))
        }
    }
}
