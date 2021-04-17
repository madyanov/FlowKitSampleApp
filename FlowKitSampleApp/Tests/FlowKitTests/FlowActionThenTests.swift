import XCTest
import FlowKit

final class FlowActionThenTests: XCTestCase {
    func testThenWithoutErrors() {
        let expectation = self.expectation(description: "then without errors")
        let finallyNode = VoidFlowNodeMock()
        let sumNode = SumFlowNodeMock()
        let stringNode = StringFlowNodeMock<Int>()

        FlowAction<[Int]> { completion in
            Async(expectation) { completion(.success([3, 4, 5, 6, 7, 8, 9])) }
        }
        .then(sumNode)
        .then(stringNode)
        .finally(finallyNode)

        waitForExpectations(timeout: 1) { error in
            XCTAssertNil(error)
            XCTAssertEqual(sumNode.sum, 42)
            XCTAssertEqual(stringNode.string, "42")
            XCTAssertTrue(finallyNode.actionExecuted)
        }
    }

    func testThenWithError() {
        let expectation = self.expectation(description: "then with error")
        let finallyNode = VoidFlowNodeMock()
        let sumNode = SumFlowNodeMock()
        let stringNode = StringFlowNodeMock<Int>()

        FlowAction<[Int]> { completion in
            Async(expectation) { completion(.failure(ErrorMock.someError)) }
        }
        .then(sumNode)
        .then(stringNode)
        .finally(finallyNode)

        waitForExpectations(timeout: 1) { error in
            XCTAssertNil(error)
            XCTAssertNil(sumNode.sum)
            XCTAssertNil(stringNode.string)
            XCTAssertTrue(finallyNode.actionExecuted)
        }
    }
}