import PromiseKit

protocol CreateTransferNodeDependencies {
    var transfersRepository: TransfersRepository { get }
}

struct CreateTransferNode: PromiseBuilder {
    private let countryPromise: Promise<Country>
    private let amountPromise: Promise<Int>
    private let dependencies: CreateTransferNodeDependencies

    init(_ dependencies: CreateTransferNodeDependencies,
         countryPromise: Promise<Country>,
         amountPromise: Promise<Int>) {

        self.countryPromise = countryPromise
        self.amountPromise = amountPromise
        self.dependencies = dependencies
    }

    func build(with: Void) -> Promise<Transfer> {
        return Promise<Transfer> { completion in
            zip(countryPromise, amountPromise)
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
