import FlowKit

protocol BackToRootNodeDependencies {
    var navigator: RouteNavigator { get }
}

struct BackToRootNode<Output>: FlowNode {
    private let dependencies: BackToRootNodeDependencies

    init(_ dependencies: BackToRootNodeDependencies) {
        self.dependencies = dependencies
    }

    func makeAction(with output: Output) -> FlowAction<Output> {
        return FlowAction {
            dependencies.navigator.backToRoot()
            $0(.success(output))
        }
    }
}
