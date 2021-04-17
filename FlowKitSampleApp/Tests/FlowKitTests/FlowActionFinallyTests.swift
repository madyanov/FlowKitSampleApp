import XCTest
import FlowKit

final class FlowActionFinallyTests: XCTestCase {
    func testFinallyExecutedWithoutErrors() {
        let expectation = self.expectation(description: "finally without errors")
        let catchNode = VoidFlowNodeMock()
        let finallyNode = VoidFlowNodeMock()

        FlowAction<Void> { completion in
            Async(expectation) { completion(.success(())) }
        }
        .catch { _ in catchNode }
        .finally(finallyNode)

        waitForExpectations(timeout: 1) { error in
            XCTAssertNil(error)
            XCTAssertFalse(catchNode.actionExecuted)
            XCTAssertTrue(finallyNode.actionExecuted)
        }
    }

    func testFinallyExecutedWithError() {
        let expectation = self.expectation(description: "finally with error")
        let catchNode = VoidFlowNodeMock()
        let finallyNode = VoidFlowNodeMock()

        FlowAction<Void> { completion in
            Async(expectation) { completion(.failure(ErrorMock.someError)) }
        }
        .catch { _ in catchNode }
        .finally(finallyNode)

        waitForExpectations(timeout: 1) { error in
            XCTAssertNil(error)
            XCTAssertTrue(catchNode.actionExecuted)
            XCTAssertTrue(finallyNode.actionExecuted)
        }
    }
}