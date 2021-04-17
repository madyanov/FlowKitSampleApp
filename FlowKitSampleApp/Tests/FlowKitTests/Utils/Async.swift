import Foundation
import Dispatch
import XCTest

func async(_ completion: @escaping () -> Void) {
    DispatchQueue.main.async(execute: completion)
}

struct Async {
    @discardableResult
    init(_ expectation: XCTestExpectation, completion: @escaping () -> Void) {
        async {
            completion()
            expectation.fulfill()
        }
    }
}
