import FlowKit

final class ErrorFlowNodeMock<Output>: FlowNode {
    private let error: ErrorMock

    init(_ error: ErrorMock) {
        self.error = error
    }

    func makeAction(with: Void) -> FlowAction<Output> {
        return FlowAction { $0(.failure(self.error)) }
    }
}
