import NavigationKit

struct TransferFlowDependencies {
    let navigator: Navigator<Route, ModuleBuilder>
    let transfersRepository: TransfersRepository
}

extension TransferFlowDependencies: NavigationNodeDependencies { }
extension TransferFlowDependencies: BackToRootNodeDependencies { }
extension TransferFlowDependencies: CreateTransferNodeDependencies { }
