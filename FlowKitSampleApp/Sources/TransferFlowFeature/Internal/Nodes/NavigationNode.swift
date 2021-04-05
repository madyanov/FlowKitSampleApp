import PromiseKit
import NavigationKit

protocol NavigationNodeDependencies {
    var navigator: Navigator<Route, ModuleBuilder> { get }
}

struct NavigationNode<Output>: PromiseBuilder {
    private let dependencies: NavigationNodeDependencies

    init(_ dependencies: NavigationNodeDependencies) {
        self.dependencies = dependencies
    }

    func build(with route: Route) -> Promise<Output> {
        return Promise<Output> { completion in
            let route = route.overriding { completion(.success($0)) }
            dependencies.navigator.forward(to: route)
        }
    }
}
