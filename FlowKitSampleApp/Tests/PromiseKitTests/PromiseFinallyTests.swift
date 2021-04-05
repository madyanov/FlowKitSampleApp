import XCTest
import PromiseKit

final class PromiseFinallyTests: XCTestCase {
    func testFinallyExecutedWithoutErrors() {
        let expectation = self.expectation(description: "finally without errors")
        let catchBuilder = VoidPromiseBuilderMock()
        let finallyBuilder = VoidPromiseBuilderMock()

        Promise<Void> { completion in
            Async(expectation) { completion(.success(())) }
        }
        .catch { _ in catchBuilder }
        .finally(finallyBuilder)

        waitForExpectations(timeout: 1) { error in
            XCTAssertNil(error)
            XCTAssertFalse(catchBuilder.promiseExecuted)
            XCTAssertTrue(finallyBuilder.promiseExecuted)
        }
    }

    func testFinallyExecutedWithError() {
        let expectation = self.expectation(description: "finally with error")
        let catchBuilder = VoidPromiseBuilderMock()
        let finallyBuilder = VoidPromiseBuilderMock()

        Promise<Void> { completion in
            Async(expectation) { completion(.failure(ErrorMock.someError)) }
        }
        .catch { _ in catchBuilder }
        .finally(finallyBuilder)

        waitForExpectations(timeout: 1) { error in
            XCTAssertNil(error)
            XCTAssertTrue(catchBuilder.promiseExecuted)
            XCTAssertTrue(finallyBuilder.promiseExecuted)
        }
    }
}
