protocol TransferRepository {
    func createTransfer(country: Country, amount: Int, tariff: Tariff, completion: @escaping (Transfer) -> Void)
}
