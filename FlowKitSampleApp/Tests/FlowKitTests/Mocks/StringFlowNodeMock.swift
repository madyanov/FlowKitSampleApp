import FlowKit

final class StringFlowNodeMock<Input: CustomStringConvertible>: FlowNode {
    typealias Output = String

    private(set) var string: String?

    func action(with input: Input) -> FlowAction<Output> {
        return FlowAction { completion in
            let string = "\(input)"
            self.string = string
            completion(.success(string))
        }
    }
}
