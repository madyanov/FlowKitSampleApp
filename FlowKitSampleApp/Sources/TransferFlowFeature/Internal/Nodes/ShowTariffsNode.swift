import FlowKit

protocol ShowTariffsNodeDependencies {
    var state: TransferFlowState { get }
    var navigator: RouteNavigator { get }
}

struct ShowTariffsNode: FlowNode {
    typealias Input = TemporaryTransferWithAmount
    typealias Output = TemporaryTransferWithTariff

    private let dependencies: ShowTariffsNodeDependencies

    init(_ dependencies: ShowTariffsNodeDependencies) {
        self.dependencies = dependencies
    }

    func action(with transfer: Input) -> FlowAction<Output> {
        return FlowAction { completion in
            dependencies.navigator.forward(to: .tariffs(tariffPublisher: dependencies.state.tariff,
                                                        completion: {
                                                            dependencies.state.tariff.value = $0

                                                            let transfer = TemporaryTransferWithTariff(country: transfer.country,
                                                                                                       amount: transfer.amount,
                                                                                                       tariff: $0)
                                                            completion(.success(transfer))
                                                        }))
        }
    }
}
