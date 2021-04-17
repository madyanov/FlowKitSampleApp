import FlowKit

final class SumFlowNodeMock: FlowNode {
    private(set) var sum: Int?

    func makeAction(with values: [Int]) -> FlowAction<Int> {
        return FlowAction<Int> { completion in
            let sum = values.reduce(0, +)
            self.sum = sum
            completion(.success(sum))
        }
    }
}
