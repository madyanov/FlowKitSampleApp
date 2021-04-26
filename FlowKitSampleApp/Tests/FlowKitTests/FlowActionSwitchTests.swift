import XCTest
@testable import FlowKit

final class FlowActionSwitchTests: XCTestCase {
    func testSwitch() {
        let expectation = self.expectation(description: "switch")
        let sumNode = SumFlowNodeMock()
        let stringNode = StringFlowNodeMock<Int>()
        var result: String?

        let initialIntArray = [3, 4, 5, 6, 7, 8, 9]
        let expectedSumNodeResult = 42 // initialIntArray.reduce(0, +)
        let expectedStringNodeResult = "42" // "\(expectedSumNodeResult)"

        FlowAction<[Int]> { completion in
            Async(expectation) { completion(.success(initialIntArray)) }
        }
        .then(sumNode)
        .switch {
            $0
                .when({ $0 < expectedSumNodeResult }, then: ErrorFlowNodeMock<String>(ErrorMock.someError))
                .when({ $0 == expectedSumNodeResult }, then: stringNode)
                .default(ErrorFlowNodeMock<String>(ErrorMock.unknownError))
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
            XCTAssertEqual(sumNode.sum, expectedSumNodeResult)
            XCTAssertEqual(stringNode.string, expectedStringNodeResult)
            XCTAssertEqual(result, expectedStringNodeResult)
        }
    }
}
