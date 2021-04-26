import XCTest
import FlowKit
@testable import TransferFlowFeature

final class TransferFlowTests: XCTestCase {
    private lazy var navigator = RouteNavigatorMock()

    private lazy var transferFlow: TransferFlow = {
        let transferRepository = RandomTransferRepositoryMock()
        let dependencies = TransferFlowDependencies(navigator: navigator,
                                                    transferRepository: transferRepository)
        return TransferFlow(dependencies: dependencies)
    }()

    func testTransferFlowCompleteWithValidAmount() {
        let inputAmount = 142

        navigator.routeResultMaker = { route in
            switch route {
            case .amount: return inputAmount
            default: return nil
            }
        }

        let expectation = self.expectation(description: "transfer flow valid amount")
        var resultTransfer: Transfer?
        var resultError: Error?

        let completion: (Result<Transfer, Error>) -> Void = { result in
            switch result {
            case .success(let transfer):
                resultTransfer = transfer
            case .failure(let error):
                resultError = error
            }

            expectation.fulfill()
        }

        FlowKit
            .initialize(with: .russia)
            .then(transferFlow)
            .complete(using: completion)

        waitForExpectations(timeout: 1) { error in
            XCTAssertNil(error)
            XCTAssertNil(resultError)
            XCTAssertEqual(resultTransfer?.country, .russia)
            XCTAssertEqual(resultTransfer?.amount, inputAmount)
            XCTAssertNil(self.navigator.currentRoute)
        }
    }

    func testTransferFlowIncompleteBecauseOfInvalidAmount() {
        let inputAmount = 42

        navigator.routeResultMaker = { route in
            switch route {
            case .amount: return inputAmount
            default: return nil
            }
        }

        var resultTransfer: Transfer?
        var resultError: Error?

        let completion: (Result<Transfer, Error>) -> Void = { result in
            switch result {
            case .success(let transfer):
                resultTransfer = transfer
            case .failure(let error):
                resultError = error
            }
        }

        FlowKit
            .initialize(with: .russia)
            .then(transferFlow)
            .complete(using: completion)

        XCTAssertNil(resultError)
        XCTAssertNil(resultTransfer)

        switch self.navigator.currentRoute {
        case .invalidAmount: break
        default: XCTFail()
        }
    }
}