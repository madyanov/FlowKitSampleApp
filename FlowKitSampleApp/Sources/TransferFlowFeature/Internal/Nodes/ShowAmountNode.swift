import FlowKit
import NavigationKit

protocol ShowAmountNodeDependencies {
    var navigator: Navigator<Route, ModuleBuilder> { get }
}

struct ShowAmountNode: FlowNode {
    private let dependencies: ShowAmountNodeDependencies

    init(_ dependencies: ShowAmountNodeDependencies) {
        self.dependencies = dependencies
    }

    func makeAction(with country: Country) -> FlowAction<TemporaryTransfer> {
        return FlowAction<TemporaryTransfer> { completion in
            dependencies.navigator.forward(to: .amount(country: country,
                                                       completion: {
                                                        completion(.success(TemporaryTransfer(country: country, amount: $0)))
                                                       }))
        }
    }
}
