import XCTest
@testable import PromiseKit

final class PromiseTests: XCTestCase {
    func testSyncComplete() {
        var result: Int?

        Promise { $0(.success(42)) }
            .complete {
                switch $0 {
                case .success(let value):
                    result = value
                case .failure:
                    break
                }
            }

        XCTAssertEqual(result, 42)
    }

    func testAsyncComplete() {
        let expectation = self.expectation(description: "async then")
        var result: Int?

        Promise { completion in
            Async(expectation) { completion(.success(42)) }
        }
        .complete {
            switch $0 {
            case .success(let value):
                result = value
            case .failure:
                break
            }
        }

        waitForExpectations(timeout: 1) { error in
            XCTAssertNil(error)
            XCTAssertEqual(result, 42)
        }
    }
}
