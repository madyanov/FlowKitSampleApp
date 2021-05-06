import UIKit

@testable import TransferFlowFeature

final class RouteNavigatorMock {
    var currentRoute: Route?
    var routeResultMaker: ((Route) -> Any?)?
}

extension RouteNavigatorMock: RouteNavigator {
    func forward(to route: Route) -> UIViewController? {
        currentRoute = route

        switch route {
        case .amount(_, let completion):
            guard let amount = routeResultMaker?(route) as? Int else { return nil }
            completion(amount)
        case .tariffs(_, let completion):
            guard let tariff = routeResultMaker?(route) as? Tariff else { return nil }
            completion(tariff)
        case .confirmation(_, _, _, _, let completion):
            guard let result = routeResultMaker?(route) as? ConfirmationResult else { return nil }
            completion(result)
        case .success(_, let completion):
            completion()
        case .invalidAmount:
            break
        }

        return nil
    }

    func back() { }

    func back(to: Int) { }

    func backToRoot() {
        currentRoute = nil
    }
}
