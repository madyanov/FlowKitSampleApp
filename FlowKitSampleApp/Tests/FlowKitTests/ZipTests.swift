import XCTest
import FlowKit

final class ZipTests: XCTestCase {
    func testZipOfThreeActions() {
        let expectation = self.expectation(description: "zip of three actions")

        let expectedAction1Result = 42
        let expectedAction2Result = 43
        let expectedAction3Result = 44

        let action1 = FlowAction { completion in
            async { completion(.success(expectedAction1Result)) }
        }

        let action2 = FlowAction { completion in
            async { completion(.success(expectedAction2Result)) }
        }

        let action3 = FlowAction { completion in
            async { completion(.success(expectedAction3Result)) }
        }

        var result: (Int, Int, Int)?

        zip(action1, action2, action3)
            .success {
                result = $0
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
