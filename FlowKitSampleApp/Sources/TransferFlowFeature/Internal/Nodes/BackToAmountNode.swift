import FlowKit

protocol BackToAmountNodeDependencies {
    var navigator: RouteNavigator { get }
}

struct BackToAmountNode: FlowNode {
    private let dependencies: BackToAmountNodeDependencies

    init(_ dependencies: BackToAmountNodeDependencies) {
        self.dependencies = dependencies
    }

    func action(with transfer: TemporaryTransferWithTariff) -> FlowAction<TemporaryTransferWithTariff> {
        return FlowAction { _ in
            dependencies.navigator.back(to: 1)
        }
    }
}
