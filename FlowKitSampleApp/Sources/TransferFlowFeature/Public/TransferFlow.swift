import PromiseKit

public struct TransferFlow: PromiseBuilder {
    private let dependencies: TransferFlowDependencies

    init(dependencies: TransferFlowDependencies) {
        self.dependencies = dependencies
    }

    public func build(with country: Country) -> Promise<Transfer> {
        return Promise<Transfer> { completion in
            return initialize(with: country)
                .then(showAmount)
                .complete(with: completion)
        }
    }
}

private extension TransferFlow {
    func showAmount(_ countryPromise: Promise<Country>) -> Promise<Transfer> {
        return countryPromise
            .then(ShowAmountNode())
            .then(NavigationNode<Int>(dependencies))
            .then { amountPromise in
                amountPromise
                    .then(CheckAmountNode())
                    .switch {
                        $0
                            .when({ $0 == .invalid }, then: showInvalidAmount(amountPromise: amountPromise,
                                                                              countryPromise: countryPromise))
                            .default(showConfirmation(amountPromise: amountPromise,
                                                      countryPromise: countryPromise))
                    }
            }
            .then(BackToRootNode(dependencies))
    }

    func showConfirmation(amountPromise: Promise<Int>, countryPromise: Promise<Country>) -> Promise<Transfer> {
        amountPromise
            .then(ShowConfirmationNode(countryPromise: countryPromise))
            .then(NavigationNode<Void>(dependencies))
            .then(CreateTransferNode(dependencies, countryPromise: countryPromise, amountPromise: amountPromise))
            .then {
                $0
                    .then(ShowSuccessNode())
                    .then(NavigationNode<Void>(dependencies))
                    .then($0)
            }
    }

    func showInvalidAmount(amountPromise: Promise<Int>, countryPromise: Promise<Country>) -> Promise<Transfer> {
        amountPromise
            .then(ShowInvalidAmountNode())
            .then(NavigationNode<Void>(dependencies))
            .then(showConfirmation(amountPromise: amountPromise, countryPromise: countryPromise))
    }
}
