import FlowKit

protocol CreateTransferNodeDependencies {
    var transfersRepository: TransfersRepository { get }
}

struct CreateTransferNode: FlowNode {
    private let dependencies: CreateTransferNodeDependencies

    init(_ dependencies: CreateTransferNodeDependencies) {
        self.dependencies = dependencies
    }

    func makeAction(with transfer: TemporaryTransfer) -> FlowAction<Transfer> {
        return FlowAction<Transfer> { completion in
            dependencies
                .transfersRepository
                .createTransfer(country: transfer.country,
                                amount: transfer.amount) { completion(.success($0)) }
        }
    }
}
