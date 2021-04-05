import PromiseKit

struct ShowSuccessNode: PromiseBuilder {
    func build(with transfer: Transfer) -> Promise<Route> {
        return Promise<Route> { $0(.success(.success(transfer: transfer, completion: {}))) }
    }
}
