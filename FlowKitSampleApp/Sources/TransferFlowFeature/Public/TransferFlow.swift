import FlowKit

public struct TransferFlow: FlowNode {
    public typealias Input = Country
    public typealias Output = Transfer

    private let dependencies: TransferFlowDependencies

    init(dependencies: TransferFlowDependencies) {
        self.dependencies = dependencies
    }

    public func action(with country: Input) -> FlowAction<Output> {
        let contextProvider = ApplicationContextProvider()

        return FlowAction { completion in
            return initialize(with: country)
                .then(ShowAmountNode(dependencies))
                .switch(TransformAmountResultToValidity()) { $0
                    .when({ $0 == .invalid }, then: ShowInvalidAmountNode(dependencies))
                    .continue()
                }
                .then(TransformAmountResultToTransferWithTariff()) { $0
                    .then(TransformAmountResultToTransferWithAmount())
                    .then(ShowTariffsNode(dependencies))
                }
                .then(ShowConfirmationNode(dependencies))
                .switch(TransformConfirmationResultToStep(),
                        transformer: TransformConfirmationResultToTransfer()) { $0
                    .when({ $0 == .editAmount }, then: BackToAmountNode(dependencies))
                    .when({ $0 == .editTariff }, then: BackToTariffsNode(dependencies))
                    .continue()
                }
                .then(CreateTransferNode(dependencies)
                        .disposable()
                        .cancellable(contextProvider: contextProvider))
                .then(ShowSuccessNode(dependencies))
                .then(EndFlowNode(dependencies))
                .catch { _ in EndFlowNode(dependencies).erase() }
                .complete(using: completion)
        }
    }
}
