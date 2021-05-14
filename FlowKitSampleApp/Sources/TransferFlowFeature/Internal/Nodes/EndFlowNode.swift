import FlowKit

protocol EndFlowNodeDependencies {
    var navigator: RouteNavigator { get }
}

struct EndFlowNode<Output>: FlowNode {
    typealias Input = Output

    private let dependencies: EndFlowNodeDependencies

    init(_ dependencies: EndFlowNodeDependencies) {
        self.dependencies = dependencies
    }

    func action(with input: Output) -> FlowAction<Output> {
        return FlowAction {
            dependencies.navigator.backToRoot()
            $0(.success(input))
        }
    }
}
