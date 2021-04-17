import FlowKit
import NavigationKit

protocol BackToRootNodeDependencies {
    var navigator: Navigator<Route, ModuleBuilder> { get }
}

struct BackToRootNode<Value>: FlowNode {
    private let dependencies: BackToRootNodeDependencies

    init(_ dependencies: BackToRootNodeDependencies) {
        self.dependencies = dependencies
    }

    func makeAction(with value: Value) -> FlowAction<Value> {
        return FlowAction<Value> {
            dependencies.navigator.backToRoot()
            $0(.success(value))
        }
    }
}
