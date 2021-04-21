import FlowKit
import NavigationKit

protocol ShowSuccessDependencies {
    var navigator: Navigator<Route, ModuleBuilder> { get }
}

struct ShowSuccessNode: FlowNode {
    private let dependencies: ShowSuccessDependencies

    init(_ dependencies: ShowSuccessDependencies) {
        self.dependencies = dependencies
    }

    func makeAction(with transfer: Transfer) -> FlowAction<Void> {
        return FlowAction<Void> { completion in
            dependencies.navigator.forward(to: .success(transfer: transfer,
                                                        completion: { completion(.success(())) }))
        }
    }
}
