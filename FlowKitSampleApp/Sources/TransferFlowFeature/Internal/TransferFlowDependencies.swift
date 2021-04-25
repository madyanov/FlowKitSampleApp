struct TransferFlowDependencies {
    let navigator: RouteNavigator
    let transferRepository: TransferRepository
}

extension TransferFlowDependencies: BackToRootNodeDependencies { }
extension TransferFlowDependencies: CreateTransferNodeDependencies { }
extension TransferFlowDependencies: ShowAmountNodeDependencies { }
extension TransferFlowDependencies: ShowConfirmationNodeDependencies { }
extension TransferFlowDependencies: ShowInvalidAmountDependencies { }
extension TransferFlowDependencies: ShowSuccessDependencies { }
