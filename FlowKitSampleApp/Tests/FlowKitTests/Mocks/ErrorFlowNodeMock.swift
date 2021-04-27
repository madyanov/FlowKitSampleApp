import FlowKit

final class ErrorFlowNodeMock<Value>: FlowNode {
    private let error: ErrorMock

    init(_ error: ErrorMock) {
        self.error = error
    }

    func makeAction(with: Void) -> FlowAction<Value> {
        return FlowAction { $0(.failure(self.error)) }
    }
}
