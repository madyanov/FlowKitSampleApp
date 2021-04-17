import XCTest
@testable import FlowKit

final class FlowActionSwitchTests: XCTestCase {
    func testSwitch() {
        let expectation = self.expectation(description: "switch")
        let sumNode = SumFlowNodeMock()
        let stringNode = StringFlowNodeMock<Int>()
        var result: String?

        FlowAction<[Int]> { completion in
            Async(expectation) { completion(.success([3, 4, 5, 6, 7, 8, 9])) }
        }
        .then(sumNode)
        .switch {
            $0
                .when({ $0 < 42 }, then: ErrorFlowNodeMock<String>(ErrorMock.someError))
                .when({ $0 == 42 }, then: stringNode)
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
            XCTAssertEqual(sumNode.sum, 42)
            XCTAssertEqual(stringNode.string, "42")
            XCTAssertEqual(result, "42")
        }
    }
}
