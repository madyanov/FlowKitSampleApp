import XCTest
import PromiseKit

final class ZipTests: XCTestCase {
    func testZip2() {
        let expectation = self.expectation(description: "zip2")

        let p1 = Promise<Int> { completion in
            async { completion(.success(42)) }
        }

        let p2 = Promise<Int> { completion in
            async { completion(.success(43)) }
        }

        var result: (Int, Int)?

        zip(p1, p2)
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
        }
    }
}
