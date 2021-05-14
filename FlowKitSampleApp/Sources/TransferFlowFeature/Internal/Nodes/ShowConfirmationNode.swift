import FlowKit

protocol ShowConfirmationNodeDependencies {
    var state: TransferFlowState { get }
    var navigator: RouteNavigator { get }
}

struct ShowConfirmationNode: FlowNode {
    typealias Input = TemporaryTransferWithTariff
    typealias Output = (result: ConfirmationResult, transfer: TemporaryTransferWithTariff)

    private let dependencies: ShowConfirmationNodeDependencies

    init(_ dependencies: ShowConfirmationNodeDependencies) {
        self.dependencies = dependencies
    }

    func action(with transfer: Input) -> FlowAction<Output> {
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
