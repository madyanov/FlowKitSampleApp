import FlowKit

protocol ShowAmountNodeDependencies {
    var state: TransferFlowState { get }
    var navigator: RouteNavigator { get }
}

struct ShowAmountNode: FlowNode {
    enum Result {
        case transferWithAmount(TemporaryTransferWithAmount)
        case transferWithTariff(TemporaryTransferWithTariff)
    }

    private let dependencies: ShowAmountNodeDependencies

    init(_ dependencies: ShowAmountNodeDependencies) {
        self.dependencies = dependencies
    }

    func action(with country: Country) -> FlowAction<Result> {
        return FlowAction { completion in
            dependencies.navigator.forward(to: .amount(country: country,
                                                       completion: { amount in
                                                        switch dependencies.state.tariff.value {
                                                        case .some(let tariff):
                                                            let transfer = TemporaryTransferWithTariff(country: country,
                                                                                                       amount: amount,
                                                                                                       tariff: tariff)
                                                            completion(.success(.transferWithTariff(transfer)))
                                                        case .none:
                                                            let transfer = TemporaryTransferWithAmount(country: country,
                                                                                                       amount: amount)
                                                            completion(.success(.transferWithAmount(transfer)))
                                                        }
                                                       }))
        }
    }
}
