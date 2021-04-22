import FlowKit
import NavigationKit

protocol ShowConfirmationNodeDependencies {
    var navigator: Navigator<Route, ModuleBuilder> { get }
}

struct ShowConfirmationNode: FlowNode {
    private let dependencies: ShowConfirmationNodeDependencies

    init(_ dependencies: ShowConfirmationNodeDependencies) {
        self.dependencies = dependencies
    }

    func makeAction(with transfer: TemporaryTransfer) -> FlowAction<TemporaryTransfer> {
        return FlowAction<TemporaryTransfer> { completion in
            dependencies.navigator.forward(to: .confirmation(country: transfer.country,
                                                             amount: transfer.amount,
                                                             completion: { completion(.success(transfer)) }))
        }
    }
}
