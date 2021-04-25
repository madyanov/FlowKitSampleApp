import NavigationKit
import UIKit

protocol RouteNavigator {
    @discardableResult
    func forward(to route: Route) -> UIViewController?
    func backToRoot()
}
