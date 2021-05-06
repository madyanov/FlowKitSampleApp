import UIKit

public struct NavigationDriver {
    private let navigationController: UINavigationController

    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func forward(to viewController: UIViewController) {
        navigationController.pushViewController(viewController, animated: true)
    }

    func back() {
        navigationController.popViewController(animated: true)
    }

    func back(to index: Int) {
        navigationController.popToViewController(navigationController.viewControllers[index], animated: true)
    }

    func backToRoot() {
        navigationController.popToRootViewController(animated: true)
    }
}
