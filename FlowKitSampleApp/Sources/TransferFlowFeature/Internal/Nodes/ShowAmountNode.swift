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

    func makeAction(with country: Country) -> FlowAction<Int> {
        return FlowAction<Int> { completion in
            dependencies.navigator.forward(to: .amount(country: country,
                                                       completion: { completion(.success($0)) }))
        }
    }
}
