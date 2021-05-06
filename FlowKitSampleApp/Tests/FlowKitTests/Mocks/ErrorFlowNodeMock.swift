import FlowKit

final class ErrorFlowNodeMock<Output>: FlowNode {
    private let error: ErrorMock

    init(error: ErrorMock) {
        self.error = error
    }

    func action(with: Void) -> FlowAction<Output> {
        return FlowAction { $0(.failure(self.error)) }
    }
}
