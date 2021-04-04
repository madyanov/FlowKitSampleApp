enum Route {
    case amount(country: Country, completion: (Int) -> Void)
    case confirmation(country: Country, amount: Int, completion: () -> Void)
    case success(transfer: Transfer, completion: () -> Void)
    case invalidAmount

    func overriding<Output>(_ overriden: @escaping (Output) -> Void) -> Route {
        switch self {
        case .amount(let country, let completion):
            return .amount(country: country) {
                completion($0)
                ($0 as? Output).map(overriden)
            }
        case .confirmation(let country, let amount, let completion):
            return .confirmation(country: country, amount: amount) {
                completion()
                (() as? Output).map(overriden)
            }
        case .success(let transfer, let completion):
            return .success(transfer: transfer) {
                completion()
                (() as? Output).map(overriden)
            }
        case .invalidAmount:
            return .invalidAmount
        }
    }
}
