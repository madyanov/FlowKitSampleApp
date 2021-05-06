import PromiseKit

enum Route {
    case amount(country: Country, completion: (Int) -> Void)
    case tariffs(tariffPublisher: Publisher<Tariff>, completion: (Tariff) -> Void)
    case confirmation(country: Country, amount: Int, tariff: Tariff, completion: (ConfirmationResult) -> Void)
    case success(transfer: Transfer, completion: () -> Void)
    case invalidAmount
}
