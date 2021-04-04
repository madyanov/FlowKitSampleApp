import Dispatch

final class TransfersRepository {
    func createTransfer(country: Country, amount: Int, completion: @escaping (Transfer) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            let transfer = Transfer(identifier: Int.random(in: 0..<1000),
                                    country: country,
                                    amount: amount)
            completion(transfer)
        }
    }
}
