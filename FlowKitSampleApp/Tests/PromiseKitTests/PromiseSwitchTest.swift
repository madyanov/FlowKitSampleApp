import XCTest
@testable import PromiseKit

final class PromiseSwitchTests: XCTestCase {
    func testSwitch() {
        let expectation = self.expectation(description: "switch")
        let sumBuilder = SumPromiseBuilderMock()
        let stringBuilder = StringPromiseBuilderMock<Int>()
        var result: String?

        Promise<[Int]> { completion in
            Async(expectation) { completion(.success([3, 4, 5, 6, 7, 8, 9])) }
        }
        .then(sumBuilder)
        .switch {
            $0
                .when({ $0 < 42 }, then: ErrorPromiseBuilderMock<String>(ErrorMock.someError))
                .when({ $0 == 42 }, then: stringBuilder)
                .default(ErrorPromiseBuilderMock<String>(ErrorMock.unknownError))
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
            XCTAssertEqual(sumBuilder.sum, 42)
            XCTAssertEqual(stringBuilder.string, "42")
            XCTAssertEqual(result, "42")
        }
    }
}
