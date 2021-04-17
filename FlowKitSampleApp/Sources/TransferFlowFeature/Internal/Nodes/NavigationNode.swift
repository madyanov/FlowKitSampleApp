import FlowKit
import NavigationKit

protocol NavigationNodeDependencies {
    var navigator: Navigator<Route, ModuleBuilder> { get }
}

struct NavigationNode<Output>: FlowNode {
    private let dependencies: NavigationNodeDependencies

    init(_ dependencies: NavigationNodeDependencies) {
        self.dependencies = dependencies
    }

    func makeAction(with route: Route) -> FlowAction<Output> {
        return FlowAction<Output> { completion in
            let route = route.overriding { completion(.success($0)) }
            dependencies.navigator.forward(to: route)
        }
    }
}
