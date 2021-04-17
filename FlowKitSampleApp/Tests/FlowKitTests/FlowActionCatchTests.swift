import XCTest
import FlowKit

final class FlowActionCatchTests: XCTestCase {
    func testCatch() {
        let expectation = self.expectation(description: "catch")
        let node = VoidFlowNodeMock()

        FlowAction<Void> { completion in
            Async(expectation) { completion(.failure(ErrorMock.someError)) }
        }
        .catch { _ in  node }
        .execute()

        waitForExpectations(timeout: 1) { error in
            XCTAssertNil(error)
            XCTAssertTrue(node.actionExecuted)
        }
    }
}
