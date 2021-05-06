import UIKit

public final class Navigator<Route, Builder: ModuleBuilder> where Builder.Route == Route {
    private let driver: NavigationDriver
    private let builder: Builder

    public init(driver: NavigationDriver, builder: Builder) {
        self.driver = driver
        self.builder = builder
    }

    @discardableResult
    public func forward(to route: Route) -> UIViewController? {
        let viewController = builder.build(by: route)
        driver.forward(to: viewController)
        return viewController
    }

    public func back() {
        driver.back()
    }

    public func back(to index: Int) {
        driver.back(to: index)
    }

    public func backToRoot() {
        driver.backToRoot()
    }
}
