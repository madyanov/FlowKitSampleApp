import FlowKit

protocol ShowSuccessDependencies {
    var navigator: RouteNavigator { get }
}

struct ShowSuccessNode: FlowNode {
    private let dependencies: ShowSuccessDependencies

    init(_ dependencies: ShowSuccessDependencies) {
        self.dependencies = dependencies
    }

    func makeAction(with transfer: Transfer) -> FlowAction<Transfer> {
        return FlowAction<Transfer> { completion in
            dependencies.navigator.forward(to: .success(transfer: transfer,
                                                        completion: { completion(.success(transfer)) }))
        }
    }
}
