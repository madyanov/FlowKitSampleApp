import XCTest
import PromiseKit

final class PromiseCatchTests: XCTestCase {
    func testCatch() {
        let expectation = self.expectation(description: "catch")
        let builder = VoidPromiseBuilderMock()

        Promise<Void> { completion in
            Async(expectation) { completion(.failure(ErrorMock.someError)) }
        }
        .catch { _ in  builder }
        .execute()

        waitForExpectations(timeout: 1) { error in
            XCTAssertNil(error)
            XCTAssertTrue(builder.promiseExecuted)
        }
    }
}
