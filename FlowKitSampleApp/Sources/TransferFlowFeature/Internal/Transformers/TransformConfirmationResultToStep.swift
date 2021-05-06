import FlowKit

struct TransformConfirmationResultToStep: InputTransformer {
    typealias Input = (result: ConfirmationResult, transfer: TemporaryTransferWithTariff)
    typealias Output = Step

    enum Step {
        case editAmount
        case editTariff
        case `continue`
    }

    func transform(input: Input) -> Output? {
        switch input.result {
        case .editAmount:
            return .editAmount
        case .editTariff:
            return .editTariff
        case .continue:
            return .continue
        }
    }
}
