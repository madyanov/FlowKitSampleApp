import FlowKit

final class SumFlowNodeMock: FlowNode {
    private(set) var sum: Int?

    func action(with outputs: [Int]) -> FlowAction<Int> {
        return FlowAction { completion in
            let sum = outputs.reduce(0, +)
            self.sum = sum
            completion(.success(sum))
        }
    }
}
