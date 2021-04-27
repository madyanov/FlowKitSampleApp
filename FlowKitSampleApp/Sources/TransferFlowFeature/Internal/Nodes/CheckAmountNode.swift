import FlowKit

struct CheckAmountNode: FlowNode {
    enum Result {
        case valid
        case invalid
    }

    func makeAction(with transfer: TemporaryTransfer) -> FlowAction<Result> {
        return FlowAction {
            if transfer.amount > 100 {
                $0(.success(.valid))
            } else {
                $0(.success(.invalid))
            }
        }
    }
}
