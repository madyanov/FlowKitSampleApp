import PromiseKit

final class StringPromiseBuilderMock<Value: CustomStringConvertible>: PromiseBuilder {
    private(set) var string: String?

    func build(with value: Value) -> Promise<String> {
        return Promise<String> { completion in
            let string = "\(value)"
            self.string = string
            completion(.success(string))
        }
    }
}
