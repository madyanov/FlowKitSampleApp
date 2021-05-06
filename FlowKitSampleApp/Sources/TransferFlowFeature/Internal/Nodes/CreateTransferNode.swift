import FlowKit

protocol CreateTransferNodeDependencies {
    var transferRepository: TransferRepository { get }
}

struct CreateTransferNode: FlowNode {
    private let dependencies: CreateTransferNodeDependencies

    init(_ dependencies: CreateTransferNodeDependencies) {
        self.dependencies = dependencies
    }

    func action(with transfer: TemporaryTransferWithTariff) -> FlowAction<Transfer> {
        return FlowAction { completion in
            dependencies
                .transferRepository
                .createTransfer(country: transfer.country,
                                amount: transfer.amount,
                                tariff: transfer.tariff) { completion(.success($0)) }
        }
    }
}
