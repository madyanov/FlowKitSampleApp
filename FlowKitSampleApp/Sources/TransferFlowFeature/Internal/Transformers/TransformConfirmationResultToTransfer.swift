import FlowKit

struct TransformConfirmationResultToTransfer: ValueTransformer {
    typealias Input = (result: ConfirmationResult, transfer: TemporaryTransferWithTariff)
    typealias Output = TemporaryTransferWithTariff

    func map(input: Input) -> Output {
        return input.transfer
    }
}
