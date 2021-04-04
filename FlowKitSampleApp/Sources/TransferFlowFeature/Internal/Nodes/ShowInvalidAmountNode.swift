import PromiseKit

struct ShowInvalidAmountNode: PromiseBuilder {
    func build(with: Void) -> Promise<Route> {
        return Promise<Route> { $0(.success(.invalidAmount)) }
    }
}
