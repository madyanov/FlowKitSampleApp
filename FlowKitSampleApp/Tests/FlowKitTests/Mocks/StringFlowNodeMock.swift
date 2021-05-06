import FlowKit

final class StringFlowNodeMock<Output: CustomStringConvertible>: FlowNode {
    private(set) var string: String?

    func action(with output: Output) -> FlowAction<String> {
        return FlowAction { completion in
            let string = "\(output)"
            self.string = string
            completion(.success(string))
        }
    }
}
