public protocol OptionalValueTransformer: FlowNode {
    func compactMap(input: Input) -> Output?
}

extension OptionalValueTransformer {
    public func action(with input: Input) -> FlowAction<Output> {
        return FlowAction { completion in
            compactMap(input: input).map { completion(.success($0)) }
        }
    }
}
