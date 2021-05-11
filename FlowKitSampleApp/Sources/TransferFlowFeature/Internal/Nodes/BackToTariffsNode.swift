import FlowKit

protocol BackToTariffsNodeDependencies {
    var state: TransferFlowState { get }
    var navigator: RouteNavigator { get }
}

struct BackToTariffsNode: FlowNode {
    private let dependencies: ShowTariffsNodeDependencies

    init(_ dependencies: ShowTariffsNodeDependencies) {
        self.dependencies = dependencies
    }

    func action(with transfer: TemporaryTransferWithTariff) -> FlowAction<TemporaryTransferWithTariff> {
        return FlowAction { _ in
            dependencies.state.tariff.value = transfer.tariff
            dependencies.navigator.back()
        }
    }
}
