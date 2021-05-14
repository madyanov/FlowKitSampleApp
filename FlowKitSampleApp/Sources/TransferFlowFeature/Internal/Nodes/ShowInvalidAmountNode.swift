import FlowKit

protocol ShowInvalidAmountDependencies {
    var navigator: RouteNavigator { get }
}

struct ShowInvalidAmountNode: FlowNode {
    typealias Input = Void
    typealias Output = ShowAmountNode.Result

    private let dependencies: ShowInvalidAmountDependencies

    init(_ dependencies: ShowInvalidAmountDependencies) {
        self.dependencies = dependencies
    }

    func action(with: Input) -> FlowAction<Output> {
        return FlowAction { _ in
            dependencies.navigator.forward(to: .invalidAmount)
        }
    }
}
