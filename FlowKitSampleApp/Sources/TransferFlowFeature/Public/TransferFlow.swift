import FlowKit

public struct TransferFlow: FlowNode {
    private let dependencies: TransferFlowDependencies

    init(dependencies: TransferFlowDependencies) {
        self.dependencies = dependencies
    }

    public func makeAction(with country: Country) -> FlowAction<Transfer> {
        return FlowAction { completion in
            return initialize(with: country)
                .then(ShowAmountNode(dependencies))
                .switch(CheckAmountNode()) {
                    $0
                        .when({ $0 == .invalid }, then: ShowInvalidAmountNode(dependencies))
                        .default(ShowConfirmationNode(dependencies))
                }
                .then(CreateTransferNode(dependencies))
                .then(ShowSuccessNode(dependencies))
                .then(BackToRootNode(dependencies))
                .complete(using: completion)
        }
    }
}
