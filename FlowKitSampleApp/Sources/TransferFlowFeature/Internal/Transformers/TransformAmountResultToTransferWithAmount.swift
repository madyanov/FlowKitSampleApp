import FlowKit

struct TransformAmountResultToTransferWithAmount: ValueTransformer {
    typealias Input = ShowAmountNode.Result
    typealias Output = TemporaryTransferWithAmount

    func transform(input: Input) -> Output? {
        switch input {
        case .transferWithTariff:
            return nil
        case .transferWithAmount(let transfer):
            return transfer
        }
    }
}
