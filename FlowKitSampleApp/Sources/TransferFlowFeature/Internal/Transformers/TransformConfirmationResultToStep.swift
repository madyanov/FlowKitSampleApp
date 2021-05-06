import FlowKit

struct TransformConfirmationResultToStep: ValueTransformer {
    typealias Input = (result: ConfirmationResult, transfer: TemporaryTransferWithTariff)
    typealias Output = ConfirmationResult

    func transform(input: Input) -> Output? {
        return input.result
    }
}
