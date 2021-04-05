import UIKit

public struct NavigationDriver {
    private let navigationController: UINavigationController

    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func forward(to viewController: UIViewController) {
        navigationController.pushViewController(viewController, animated: true)
    }

    func backToRoot() {
        navigationController.popToRootViewController(animated: true)
    }
}
