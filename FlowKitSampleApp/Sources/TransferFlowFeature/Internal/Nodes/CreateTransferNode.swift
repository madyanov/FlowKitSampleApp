import FlowKit

protocol CreateTransferNodeDependencies {
    var state: TransferFlowState { get }
    var transferRepository: TransferRepository { get }
}

struct CreateTransferNode: FlowNode {
    private let dependencies: CreateTransferNodeDependencies

    var disposable: Bool { return true }

    init(_ dependencies: CreateTransferNodeDependencies) {
        self.dependencies = dependencies
    }

    func action(with transfer: TemporaryTransferWithTariff) -> FlowAction<Transfer> {
        return FlowAction { completion in
            dependencies.state.loading.value = true

            dependencies
                .transferRepository
                .createTransfer(country: transfer.country,
                                amount: transfer.amount,
                                tariff: transfer.tariff) {

                    dependencies.state.loading.value = false
                    completion(.success($0))
                }
        }
    }
}
