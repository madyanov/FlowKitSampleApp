import XCTest
import PromiseKit

final class PromiseThenTests: XCTestCase {
    func testThenWithoutErrors() {
        let expectation = self.expectation(description: "then without errors")
        let finallyBuilder = VoidPromiseBuilderMock()
        let sumBuilder = SumPromiseBuilderMock()
        let stringBuilder = StringPromiseBuilderMock<Int>()

        Promise<[Int]> { completion in
            Async(expectation) { completion(.success([3, 4, 5, 6, 7, 8, 9])) }
        }
        .then(sumBuilder)
        .then(stringBuilder)
        .finally(finallyBuilder)

        waitForExpectations(timeout: 1) { error in
            XCTAssertNil(error)
            XCTAssertEqual(sumBuilder.sum, 42)
            XCTAssertEqual(stringBuilder.string, "42")
            XCTAssertTrue(finallyBuilder.promiseExecuted)
        }
    }

    func testThenWithError() {
        let expectation = self.expectation(description: "then with error")
        let finallyBuilder = VoidPromiseBuilderMock()
        let sumBuilder = SumPromiseBuilderMock()
        let stringBuilder = StringPromiseBuilderMock<Int>()

        Promise<[Int]> { completion in
            Async(expectation) { completion(.failure(ErrorMock.someError)) }
        }
        .then(sumBuilder)
        .then(stringBuilder)
        .finally(finallyBuilder)

        waitForExpectations(timeout: 1) { error in
            XCTAssertNil(error)
            XCTAssertNil(sumBuilder.sum)
            XCTAssertNil(stringBuilder.string)
            XCTAssertTrue(finallyBuilder.promiseExecuted)
        }
    }
}
