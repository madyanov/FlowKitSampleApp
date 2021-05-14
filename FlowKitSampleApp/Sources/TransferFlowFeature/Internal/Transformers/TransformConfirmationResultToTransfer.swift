import FlowKit

struct TransformConfirmationResultToTransfer: InputTransformer {
    typealias Input = (result: ConfirmationResult, transfer: TemporaryTransferWithTariff)
    typealias Output = TemporaryTransferWithTariff

    func map(input: Input) -> Output {
        return input.transfer
    }
}
