import FlowKit

public struct TransferFlow: FlowNode {
    private let dependencies: TransferFlowDependencies

    init(dependencies: TransferFlowDependencies) {
        self.dependencies = dependencies
    }

    public func action(with country: Country) -> FlowAction<Transfer> {
        return FlowAction { completion in
            return initialize(with: country)
                .then(ShowAmountNode(dependencies))
                .switch(TransformAmountResultToValidity()) { $0
                    .when({ $0 == .invalid }, then: ShowInvalidAmountNode(dependencies))
                    .continue()
                }
                .switch { $0
                    .when(TransformAmountResultToTransferWithAmount(), then: ShowTariffsNode(dependencies))
                    .default(TransformAmountResultToTransferWithTariff())
                }
                .then(ShowConfirmationNode(dependencies))
                .switch(TransformConfirmationResultToStep(),
                        transformer: TransformConfirmationResultToTransfer()) { $0
                    .when({ $0 == .editAmount }, then: BackToAmountNode(dependencies))
                    .when({ $0 == .editTariff }, then: BackToTariffsNode(dependencies))
                    .continue()
                }
                .then(CreateTransferNode(dependencies))
                .then(ShowSuccessNode(dependencies))
                .then(EndFlowNode(dependencies))
                .complete(using: completion)
        }
    }
}
