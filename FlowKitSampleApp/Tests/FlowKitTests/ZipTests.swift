import XCTest
import FlowKit

final class ZipTests: XCTestCase {
    func testZip3() {
        let expectation = self.expectation(description: "zip")

        let expectedAction1Result = 42
        let expectedAction2Result = 43
        let expectedAction3Result = 44

        let action1 = FlowAction<Int> { completion in
            async { completion(.success(expectedAction1Result)) }
        }

        let action2 = FlowAction<Int> { completion in
            async { completion(.success(expectedAction2Result)) }
        }

        let action3 = FlowAction<Int> { completion in
            async { completion(.success(expectedAction3Result)) }
        }

        var result: (Int, Int, Int)?

        zip(action1, action2, action3)
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
            XCTAssertEqual(result?.0, expectedAction1Result)
            XCTAssertEqual(result?.1, expectedAction2Result)
            XCTAssertEqual(result?.2, expectedAction3Result)
        }
    }
}
