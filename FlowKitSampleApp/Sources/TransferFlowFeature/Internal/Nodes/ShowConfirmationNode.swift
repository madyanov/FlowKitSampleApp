import FlowKit

struct ShowConfirmationNode: FlowNode {
    private let country: FlowAction<Country>

    init(country: FlowAction<Country>) {
        self.country = country
    }

    func makeAction(with amount: Int) -> FlowAction<Route> {
        return FlowAction<Route> { completion in
            country.complete {
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
