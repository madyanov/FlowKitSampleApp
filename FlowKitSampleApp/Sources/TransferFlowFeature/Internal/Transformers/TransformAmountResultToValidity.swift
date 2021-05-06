import FlowKit

struct TransformAmountResultToValidity: ValueTransformer {
    typealias Input = ShowAmountNode.Result
    typealias Output = Result

    enum Result {
        case valid
        case invalid
    }

    func transform(input: Input) -> Output? {
        let amount: Int

        switch input {
        case .transferWithAmount(let transfer):
            amount = transfer.amount
        case .transferWithTariff(let transfer):
            amount = transfer.amount
        }

        return amount > 100 ? .valid : .invalid
    }
}
