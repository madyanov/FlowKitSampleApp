import PromiseKit

struct ShowConfirmationNode: PromiseBuilder {
    private let countryPromise: Promise<Country>

    init(countryPromise: Promise<Country>) {
        self.countryPromise = countryPromise
    }

    func build(with amount: Int) -> Promise<Route> {
        return Promise<Route> { completion in
            countryPromise.complete {
                switch $0 {
                case .success(let country):
                    completion(.success(.confirmation(country: country,
                                                      amount: amount,
                                                      completion: {})))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}
