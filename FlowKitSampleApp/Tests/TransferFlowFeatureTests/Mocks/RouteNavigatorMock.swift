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
            guard let routeResult = routeResultMaker?(route) else { return nil }
            completion(routeResult as! Int)
        case .confirmation(_, _, let completion):
            completion()
        case .success(_, let completion):
            completion()
        case .invalidAmount:
            break
        }

        return nil
    }

    func backToRoot() {
        currentRoute = nil
    }
}
