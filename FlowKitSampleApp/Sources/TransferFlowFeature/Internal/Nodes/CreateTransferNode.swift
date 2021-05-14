import FlowKit

protocol CreateTransferNodeDependencies {
    var state: TransferFlowState { get }
    var transferRepository: TransferRepository { get }
}

struct CreateTransferNode: FlowNode {
    typealias Input = TemporaryTransferWithTariff
    typealias Output = Transfer

    private let dependencies: CreateTransferNodeDependencies

    init(_ dependencies: CreateTransferNodeDependencies) {
        self.dependencies = dependencies
    }

    func action(with transfer: Input) -> FlowAction<Output> {
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
