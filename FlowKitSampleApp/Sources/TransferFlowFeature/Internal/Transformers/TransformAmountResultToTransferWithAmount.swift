import FlowKit

struct TransformAmountResultToTransferWithAmount: OptionalInputTransformer {
    typealias Input = ShowAmountNode.Result
    typealias Output = TemporaryTransferWithAmount

    func compactMap(input: Input) -> Output? {
        switch input {
        case .transferWithTariff:
            return nil
        case .transferWithAmount(let transfer):
            return transfer
        }
    }
}
