import FlowKit

struct CheckAmountNode: FlowNode {
    enum Result {
        case valid
        case invalid
    }

    func makeAction(with amount: Int) -> FlowAction<Result> {
        return FlowAction<Result> {
            if amount > 100 {
                $0(.success(.valid))
            } else {
                $0(.success(.invalid))
            }
        }
    }
}
