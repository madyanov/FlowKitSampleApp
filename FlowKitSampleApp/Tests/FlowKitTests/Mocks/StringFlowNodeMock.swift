import FlowKit

final class StringFlowNodeMock<Value: CustomStringConvertible>: FlowNode {
    private(set) var string: String?

    func makeAction(with value: Value) -> FlowAction<String> {
        return FlowAction { completion in
            let string = "\(value)"
            self.string = string
            completion(.success(string))
        }
    }
}
