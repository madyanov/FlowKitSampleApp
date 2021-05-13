import XCTest
import FlowKit

final class FlowActionCatchTests: XCTestCase {
    func testCatchExecutedOnError() {
        let expectation = self.expectation(description: "catch executed on error")
        let node = VoidFlowNodeMock()

        FlowAction<Void> { completion in
            Async(expectation) { completion(.failure(ErrorMock.someError)) }
        }
        .catch { _ in node.erase() }
        .complete()

        waitForExpectations(timeout: 1) { error in
            XCTAssertNil(error)
            XCTAssertTrue(node.actionExecuted)
        }
    }
}
