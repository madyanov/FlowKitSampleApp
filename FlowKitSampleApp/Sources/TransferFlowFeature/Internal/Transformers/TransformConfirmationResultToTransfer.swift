import FlowKit

struct TransformConfirmationResultToTransfer: ValueTransformer {
    typealias Input = (result: ConfirmationResult, transfer: TemporaryTransferWithTariff)
    typealias Output = TemporaryTransferWithTariff

    func transform(input: Input) -> Output? {
        return input.transfer
    }
}
