import FlowKit
import NavigationKit

protocol ShowConfirmationNodeDependencies {
    var navigator: Navigator<Route, ModuleBuilder> { get }
}

struct ShowConfirmationNode: FlowNode {
    private let dependencies: ShowConfirmationNodeDependencies
    private let country: FlowAction<Country>

    init(_ dependencies: ShowConfirmationNodeDependencies, country: FlowAction<Country>) {
        self.dependencies = dependencies
        self.country = country
    }

    func makeAction(with amount: Int) -> FlowAction<Void> {
        return FlowAction<Void> { completion in
            country.complete {
                switch $0 {
                case .success(let country):
                    let route = Route.confirmation(country: country,
                                                   amount: amount,
                                                   completion: { completion(.success(())) })
                    dependencies.navigator.forward(to: route)
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}
