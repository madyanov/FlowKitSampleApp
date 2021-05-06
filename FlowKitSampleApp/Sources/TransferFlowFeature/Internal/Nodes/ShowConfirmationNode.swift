import FlowKit

protocol ShowConfirmationNodeDependencies {
    var state: TransferFlowState { get }
    var navigator: RouteNavigator { get }
}

struct ShowConfirmationNode: FlowNode {
    private let dependencies: ShowConfirmationNodeDependencies

    init(_ dependencies: ShowConfirmationNodeDependencies) {
        self.dependencies = dependencies
    }

    func action(with transfer: TemporaryTransferWithTariff)
        -> FlowAction<(result: ConfirmationResult, transfer: TemporaryTransferWithTariff)> {

        return FlowAction { completion in
            dependencies.navigator.forward(to: .confirmation(loadingPublisher: dependencies.state.loading,
                                                             country: transfer.country,
                                                             amount: transfer.amount,
                                                             tariff: transfer.tariff,
                                                             completion: {
                                                                completion(.success((result: $0, transfer: transfer)))
                                                             }))
        }
    }
}
