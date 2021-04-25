enum Route {
    case amount(country: Country, completion: (Int) -> Void)
    case confirmation(country: Country, amount: Int, completion: () -> Void)
    case success(transfer: Transfer, completion: () -> Void)
    case invalidAmount
}
