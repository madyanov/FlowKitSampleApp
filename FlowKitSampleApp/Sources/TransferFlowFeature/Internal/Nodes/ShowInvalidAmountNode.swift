import FlowKit

protocol ShowInvalidAmountDependencies {
    var navigator: RouteNavigator { get }
}

struct ShowInvalidAmountNode: FlowNode {
    private let dependencies: ShowInvalidAmountDependencies

    init(_ dependencies: ShowInvalidAmountDependencies) {
        self.dependencies = dependencies
    }

    func action(with result: ShowAmountNode.Result) -> FlowAction<ShowAmountNode.Result> {
        return FlowAction { _ in
            dependencies.navigator.forward(to: .invalidAmount)
        }
    }
}
