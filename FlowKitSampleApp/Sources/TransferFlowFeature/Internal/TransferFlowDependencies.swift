import NavigationKit

struct TransferFlowDependencies {
    let navigator: Navigator<Route, ModuleBuilder>
    let transfersRepository: TransfersRepository
}

extension TransferFlowDependencies: BackToRootNodeDependencies { }
extension TransferFlowDependencies: CreateTransferNodeDependencies { }
extension TransferFlowDependencies: ShowAmountNodeDependencies { }
extension TransferFlowDependencies: ShowConfirmationNodeDependencies { }
extension TransferFlowDependencies: ShowInvalidAmountDependencies { }
extension TransferFlowDependencies: ShowSuccessDependencies { }
