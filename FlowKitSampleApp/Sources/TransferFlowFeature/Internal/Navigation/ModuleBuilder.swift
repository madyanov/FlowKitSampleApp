import NavigationKit
import UIKit

final class ModuleBuilder { }

extension ModuleBuilder: NavigationKit.ModuleBuilder {
    func build(by route: Route) -> UIViewController {
        switch route {
        case .amount(let country, let completion):
            return AmountViewController(country: country, completion: completion)
        case .confirmation(let country, let amount, let completion):
            return ConfirmationViewController(country: country, amount: amount, completion: completion)
        case .success(let transfer, let completion):
            return SuccessViewController(transfer: transfer, completion: completion)
        case .invalidAmount:
            return InvalidAmountViewController()
        }
    }
}
