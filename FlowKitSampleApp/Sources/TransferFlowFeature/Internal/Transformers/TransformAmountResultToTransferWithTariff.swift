import FlowKit

struct TransformAmountResultToTransferWithTariff: InputTransformer {
    typealias Input = ShowAmountNode.Result
    typealias Output = TemporaryTransferWithTariff

    func transform(input: Input) -> Output? {
        switch input {
        case .transferWithTariff(let transfer):
            return transfer
        case .transferWithAmount:
            return nil
        }
    }
}
