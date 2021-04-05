import PromiseKit

struct ShowAmountNode: PromiseBuilder {
    func build(with country: Country) -> Promise<Route> {
        return Promise<Route> { $0(.success(.amount(country: country, completion: { _ in }))) }
    }
}
