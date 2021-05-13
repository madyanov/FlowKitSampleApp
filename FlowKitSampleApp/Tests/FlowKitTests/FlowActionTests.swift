import XCTest
import FlowKit

final class FlowActionTests: XCTestCase {
    func testSyncActionSuccessCompletion() {
        var resultOutput: Int?
        let expectedOutput = 42

        FlowAction { $0(.success(expectedOutput)) }
            .success { resultOutput = $0 }

        XCTAssertEqual(resultOutput, expectedOutput)
    }

    func testAsyncActionSuccessCompletion() {
        let expectation = self.expectation(description: "async action success completion")
        var resultOutput: Int?
        let expectedOutput = 42

        FlowAction { completion in
            Async(expectation) { completion(.success(expectedOutput)) }
        }
        .success { resultOutput = $0 }

        waitForExpectations(timeout: 1) { error in
            XCTAssertNil(error)
            XCTAssertEqual(resultOutput, expectedOutput)
        }
    }

    func testSyncActionFailureCompletion() {
        var resultError: ErrorMock?
        let expectedError = ErrorMock.someError

        FlowAction<Void> { $0(.failure(expectedError)) }
            .failure { resultError = $0 as? ErrorMock }

        XCTAssertEqual(resultError, expectedError)
    }

    func testAsyncActionFailureCompletion() {
        let expectation = self.expectation(description: "async action failure completion")
        var resultError: ErrorMock?
        let expectedError = ErrorMock.someError

        FlowAction<Void> { completion in
            Async(expectation) { completion(.failure(expectedError)) }
        }
        .failure { resultError = $0 as? ErrorMock }

        waitForExpectations(timeout: 1) { error in
            XCTAssertNil(error)
            XCTAssertEqual(resultError, expectedError)
        }
    }
}
