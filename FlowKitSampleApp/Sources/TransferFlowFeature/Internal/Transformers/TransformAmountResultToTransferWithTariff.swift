import FlowKit

struct TransformAmountResultToTransferWithTariff: OptionalValueTransformer {
    typealias Input = ShowAmountNode.Result
    typealias Output = TemporaryTransferWithTariff

    func compactMap(input: Input) -> Output? {
        switch input {
        case .transferWithTariff(let transfer):
            return transfer
        case .transferWithAmount:
            return nil
        }
    }
}
