import PromiseKit
import NavigationKit

protocol BackToRootNodeDependencies {
    var navigator: Navigator<Route, ModuleBuilder> { get }
}

struct BackToRootNode<Value>: PromiseBuilder {
    private let dependencies: BackToRootNodeDependencies

    init(_ dependencies: BackToRootNodeDependencies) {
        self.dependencies = dependencies
    }

    func build(with value: Value) -> Promise<Value> {
        return Promise<Value> {
            dependencies.navigator.backToRoot()
            $0(.success(value))
        }
    }
}
