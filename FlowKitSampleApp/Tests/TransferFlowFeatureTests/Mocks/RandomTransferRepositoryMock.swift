@testable import TransferFlowFeature

final class RandomTransferRepositoryMock { }

extension RandomTransferRepositoryMock: TransferRepository {
    func createTransfer(country: Country, amount: Int, completion: @escaping (Transfer) -> Void) {
        let transfer = Transfer(identifier: Int.random(in: 0..<1000),
                                country: country,
                                amount: amount)
        completion(transfer)
    }
}
