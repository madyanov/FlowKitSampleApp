import FlowKit
import XCTest

final class VoidFlowNodeMock: FlowNode {
    typealias Input = Void
    typealias Output = Void

    private(set) var actionExecuted = false

    func action(with: Input) -> FlowAction<Output> {
        return FlowAction { completion in
            self.actionExecuted = true
            completion(.success(()))
        }
    }
}
