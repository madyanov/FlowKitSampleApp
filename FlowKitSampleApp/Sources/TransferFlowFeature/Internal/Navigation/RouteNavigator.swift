import NavigationKit
import UIKit

protocol RouteNavigator {
    @discardableResult
    func forward(to route: Route) -> UIViewController?
    func back()
    func back(to: Int)
    func backToRoot()
}
