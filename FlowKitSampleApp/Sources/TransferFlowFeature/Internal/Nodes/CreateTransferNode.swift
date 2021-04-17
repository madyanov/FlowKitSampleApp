import FlowKit

protocol CreateTransferNodeDependencies {
    var transfersRepository: TransfersRepository { get }
}

struct CreateTransferNode: FlowNode {
    private let country: FlowAction<Country>
    private let amount: FlowAction<Int>
    private let dependencies: CreateTransferNodeDependencies

    init(_ dependencies: CreateTransferNodeDependencies,
         country: FlowAction<Country>,
         amount: FlowAction<Int>) {

        self.country = country
        self.amount = amount
        self.dependencies = dependencies
    }

    func makeAction(with: Void) -> FlowAction<Transfer> {
        return FlowAction<Transfer> { completion in
            zip(country, amount)
                .complete {
                    switch $0 {
                    case .success((let country, let amount)):
                        dependencies
                            .transfersRepository
                            .createTransfer(country: country,
                                            amount: amount) { completion(.success($0)) }
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
        }
    }
}
