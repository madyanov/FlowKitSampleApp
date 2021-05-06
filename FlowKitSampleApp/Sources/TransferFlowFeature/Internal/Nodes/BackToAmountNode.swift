import FlowKit

protocol BackToAmountNodeDependencies {
    var state: TransferFlowState { get }
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
            dependencies.state.tariff.value = transfer.tariff
        }
    }
}
