struct TransferFlowDependencies {
    let state: TransferFlowState
    let navigator: RouteNavigator
    let transferRepository: TransferRepository
}

extension TransferFlowDependencies: EndFlowNodeDependencies { }
extension TransferFlowDependencies: CreateTransferNodeDependencies { }
extension TransferFlowDependencies: ShowAmountNodeDependencies { }
extension TransferFlowDependencies: ShowConfirmationNodeDependencies { }
extension TransferFlowDependencies: ShowInvalidAmountDependencies { }
extension TransferFlowDependencies: ShowSuccessDependencies { }
extension TransferFlowDependencies: ShowTariffsNodeDependencies { }
extension TransferFlowDependencies: BackToTariffsNodeDependencies { }
extension TransferFlowDependencies: BackToAmountNodeDependencies { }
