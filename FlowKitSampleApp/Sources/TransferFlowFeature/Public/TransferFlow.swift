import FlowKit

public struct TransferFlow: FlowNode {
    private let dependencies: TransferFlowDependencies

    init(dependencies: TransferFlowDependencies) {
        self.dependencies = dependencies
    }

    public func makeAction(with country: Country) -> FlowAction<Transfer> {
        return FlowAction<Transfer> { completion in
            return initialize(with: country)
                .then(showAmount)
                .complete(using: completion)
        }
    }
}

private extension TransferFlow {
    func showAmount(_ country: FlowAction<Country>) -> FlowAction<Transfer> {
        return country
            .then(ShowAmountNode(dependencies))
            .then { amount in
                amount
                    .then(CheckAmountNode())
                    .switch {
                        $0
                            .when({ $0 == .invalid },
                                  then: showInvalidAmount(amount: amount, country: country))
                            .default(showConfirmation(amount: amount, country: country))
                    }
            }
            .then(BackToRootNode(dependencies))
    }

    func showConfirmation(amount: FlowAction<Int>, country: FlowAction<Country>) -> FlowAction<Transfer> {
        amount
            .then(ShowConfirmationNode(dependencies, country: country))
            .then(CreateTransferNode(dependencies, country: country, amount: amount))
            .then {
                $0
                    .then(ShowSuccessNode(dependencies))
                    .then($0)
            }
    }

    func showInvalidAmount(amount: FlowAction<Int>, country: FlowAction<Country>) -> FlowAction<Transfer> {
        amount
            .then(ShowInvalidAmountNode(dependencies))
            .then(showConfirmation(amount: amount, country: country))
    }
}
