import FlowKit

struct TransformConfirmationResultToStep: ValueTransformer {
    typealias Input = (result: ConfirmationResult, transfer: TemporaryTransferWithTariff)
    typealias Output = ConfirmationResult

    func map(input: Input) -> Output {
        return input.result
    }
}
