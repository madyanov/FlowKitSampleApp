import PromiseKit

final class SumPromiseBuilderMock: PromiseBuilder {
    private(set) var sum: Int?

    func build(with values: [Int]) -> Promise<Int> {
        return Promise<Int> { completion in
            let sum = values.reduce(0, +)
            self.sum = sum
            completion(.success(sum))
        }
    }
}
