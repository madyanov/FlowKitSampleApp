import FlowKit

protocol CreateTransferNodeDependencies {
    var transferRepository: TransferRepository { get }
}

struct CreateTransferNode: FlowNode {
    private let dependencies: CreateTransferNodeDependencies

    init(_ dependencies: CreateTransferNodeDependencies) {
        self.dependencies = dependencies
    }

    func makeAction(with transfer: TemporaryTransfer) -> FlowAction<Transfer> {
        return FlowAction<Transfer> { completion in
            dependencies
                .transferRepository
                .createTransfer(country: transfer.country,
                                amount: transfer.amount) { completion(.success($0)) }
        }
    }
}
