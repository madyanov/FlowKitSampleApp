import FlowKit
import XCTest

final class VoidFlowNodeMock: FlowNode {
    private(set) var actionExecuted = false

    func makeAction(with: Void) -> FlowAction<Void> {
        return FlowAction<Void> { completion in
            self.actionExecuted = true
            completion(.success(()))
        }
    }
}
