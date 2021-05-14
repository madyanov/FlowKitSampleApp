import FlowKit

final class SumFlowNodeMock: FlowNode {
    typealias Input = [Int]
    typealias Output = Int

    private(set) var sum: Int?

    func action(with inputs: Input) -> FlowAction<Output> {
        return FlowAction { completion in
            let sum = inputs.reduce(0, +)
            self.sum = sum
            completion(.success(sum))
        }
    }
}
