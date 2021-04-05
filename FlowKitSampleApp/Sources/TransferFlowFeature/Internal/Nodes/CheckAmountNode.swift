import PromiseKit

struct CheckAmountNode: PromiseBuilder {
    enum Result {
        case valid
        case invalid
    }

    func build(with amount: Int) -> Promise<Result> {
        return Promise<Result> {
            if amount > 100 {
                $0(.success(.valid))
            } else {
                $0(.success(.invalid))
            }
        }
    }
}
