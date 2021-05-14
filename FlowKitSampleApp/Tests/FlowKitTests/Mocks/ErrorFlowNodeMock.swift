import FlowKit

final class ErrorFlowNodeMock<Output>: FlowNode {
    typealias Input = Void

    private let error: ErrorMock

    init(error: ErrorMock) {
        self.error = error
    }

    func action(with: Input) -> FlowAction<Output> {
        return FlowAction { $0(.failure(self.error)) }
    }
}
