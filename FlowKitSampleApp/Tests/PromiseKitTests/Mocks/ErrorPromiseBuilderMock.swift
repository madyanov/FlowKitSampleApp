import PromiseKit

final class ErrorPromiseBuilderMock<Value>: PromiseBuilder {
    private let error: ErrorMock

    init(_ error: ErrorMock) {
        self.error = error
    }

    func build(with: Void) -> Promise<Value> {
        return Promise<Value> { $0(.failure(self.error)) }
    }
}
