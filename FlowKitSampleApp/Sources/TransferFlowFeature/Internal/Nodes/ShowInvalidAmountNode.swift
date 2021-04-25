import FlowKit

protocol ShowInvalidAmountDependencies {
    var navigator: RouteNavigator { get }
}

struct ShowInvalidAmountNode: FlowNode {
    private let dependencies: ShowInvalidAmountDependencies

    init(_ dependencies: ShowInvalidAmountDependencies) {
        self.dependencies = dependencies
    }

    func makeAction(with transfer: TemporaryTransfer) -> FlowAction<TemporaryTransfer> {
        return FlowAction<TemporaryTransfer> { completion in
            dependencies.navigator.forward(to: .invalidAmount)
        }
    }
}
