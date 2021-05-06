public protocol InputTransformer: FlowNode {
    associatedtype Input
    associatedtype Output

    func transform(input: Input) -> Output?
}

extension InputTransformer {
    public func action(with input: Input) -> FlowAction<Output> {
        return FlowAction { completion in
            transform(input: input).map { completion(.success($0)) }
        }
    }
}
