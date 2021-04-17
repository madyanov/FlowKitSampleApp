import FlowKit

struct ShowSuccessNode: FlowNode {
    func makeAction(with transfer: Transfer) -> FlowAction<Route> {
        return FlowAction<Route> { $0(.success(.success(transfer: transfer, completion: {}))) }
    }
}
