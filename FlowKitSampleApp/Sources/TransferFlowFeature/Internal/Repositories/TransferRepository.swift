protocol TransferRepository {
    func createTransfer(country: Country, amount: Int, completion: @escaping (Transfer) -> Void)
}
