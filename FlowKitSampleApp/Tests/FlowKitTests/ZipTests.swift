import XCTest
import FlowKit

final class ZipTests: XCTestCase {
    func testZip() {
        let expectation = self.expectation(description: "zip")

        let a1 = FlowAction<Int> { completion in
            async { completion(.success(42)) }
        }

        let a2 = FlowAction<Int> { completion in
            async { completion(.success(43)) }
        }

        let a3 = FlowAction<Int> { completion in
            async { completion(.success(44)) }
        }

        var result: (Int, Int, Int)?

        zip(a1, a2, a3)
            .complete {
                switch $0 {
                case .success(let value):
                    result = value
                case .failure:
                    break
                }

                expectation.fulfill()
            }

        waitForExpectations(timeout: 1) { error in
            XCTAssertNil(error)
            XCTAssertEqual(result?.0, 42)
            XCTAssertEqual(result?.1, 43)
            XCTAssertEqual(result?.2, 44)
        }
    }
}
