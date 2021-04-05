import PromiseKit
import XCTest

final class VoidPromiseBuilderMock: PromiseBuilder {
    private(set) var promiseExecuted = false

    func build(with: Void) -> Promise<Void> {
        return Promise<Void> { completion in
            self.promiseExecuted = true
            completion(.success(()))
        }
    }
}
