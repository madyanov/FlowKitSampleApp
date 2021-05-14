import FlowKit

struct TransformConfirmationResultToStep: InputTransformer {
    typealias Input = (result: ConfirmationResult, transfer: TemporaryTransferWithTariff)
    typealias Output = ConfirmationResult

    func map(input: Input) -> Output {
        return input.result
    }
}
