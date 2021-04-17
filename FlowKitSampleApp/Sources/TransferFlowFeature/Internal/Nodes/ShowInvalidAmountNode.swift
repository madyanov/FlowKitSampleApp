import FlowKit

struct ShowInvalidAmountNode: FlowNode {
    func makeAction(with: Void) -> FlowAction<Route> {
        return FlowAction<Route> { $0(.success(.invalidAmount)) }
    }
}
