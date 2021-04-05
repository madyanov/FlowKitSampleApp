import UIKit
import NavigationKit
import TransferFlowFeature
import PromiseKit

public final class App {
    private lazy var window = UIWindow()

    public init() { }

    public func launch() {
        let firstViewController = FirstViewController()
        let navigationController = UINavigationController(rootViewController: firstViewController)

        window.backgroundColor = .white
        window.rootViewController = navigationController
        window.makeKeyAndVisible()

        let navigationDriver = NavigationDriver(navigationController: navigationController)
        let transferFlowFactory = TransferFlowFactory(navigatinDriver: navigationDriver)
        let transferFlow = transferFlowFactory.makeTransferFlow()

        let completion: (Result<Transfer, Error>) -> Void = { result in
            switch result {
            case .success(let transfer):
                let alert = UIAlertController(title: "Success!",
                                              message: "Created Transfer ID: \(transfer.identifier)",
                                              preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel))
                firstViewController.present(alert, animated: true)
            case .failure:
                break
            }
        }

        firstViewController.tapRussiaButtonHandler =
            { initialize(with: .russia).then(transferFlow).complete(using: completion) }
        firstViewController.tapGermanyButtonHandler =
            { initialize(with: .germany).then(transferFlow).complete(using: completion) }
        firstViewController.tapFranceButtonHandler =
            { initialize(with: .france).then(transferFlow).complete(using: completion) }
    }
}
