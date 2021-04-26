import XCTest
@testable import FlowKit

final class FlowActionTests: XCTestCase {
    func testSyncSuccessComplete() {
        var resultValue: Int?
        let expectedValue = 42

        FlowAction { $0(.success(expectedValue)) }
            .complete {
                switch $0 {
                case .success(let value):
                    resultValue = value
                case .failure:
                    break
                }
            }

        XCTAssertEqual(resultValue, expectedValue)
    }

    func testAsyncSuccessComplete() {
        let expectation = self.expectation(description: "async success complete")
        var resultValue: Int?
        let expectedValue = 42

        FlowAction { completion in
            Async(expectation) { completion(.success(expectedValue)) }
        }
        .complete {
            switch $0 {
            case .success(let value):
                resultValue = value
            case .failure:
                break
            }
        }

        waitForExpectations(timeout: 1) { error in
            XCTAssertNil(error)
            XCTAssertEqual(resultValue, expectedValue)
        }
    }

    func testSyncFailureComplete() {
        var resultError: ErrorMock?
        let expectedError = ErrorMock.someError

        FlowAction<Void> { $0(.failure(expectedError)) }
            .complete {
                switch $0 {
                case .success:
                    break
                case .failure(let error):
                    resultError = error as? ErrorMock
                }
            }

        XCTAssertEqual(resultError, expectedError)
    }

    func testAsyncFailureComplete() {
        let expectation = self.expectation(description: "async failure complete")
        var resultError: ErrorMock?
        let expectedError = ErrorMock.someError

        FlowAction<Void> { completion in
            Async(expectation) { completion(.failure(expectedError)) }
        }
        .complete {
            switch $0 {
            case .success:
                break
            case .failure(let error):
                resultError = error as? ErrorMock
            }
        }

        waitForExpectations(timeout: 1) { error in
            XCTAssertNil(error)
            XCTAssertEqual(resultError, expectedError)
        }
    }
}
