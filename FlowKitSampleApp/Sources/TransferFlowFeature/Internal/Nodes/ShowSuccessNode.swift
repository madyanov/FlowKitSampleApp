import FlowKit

protocol ShowSuccessDependencies {
    var navigator: RouteNavigator { get }
}

struct ShowSuccessNode: FlowNode {
    typealias Input = Transfer
    typealias Output = Transfer

    private let dependencies: ShowSuccessDependencies

    init(_ dependencies: ShowSuccessDependencies) {
        self.dependencies = dependencies
    }

    func action(with transfer: Input) -> FlowAction<Output> {
        return FlowAction { completion in
            dependencies.navigator.forward(to: .success(transfer: transfer,
                                                        completion: { completion(.success(transfer)) }))
        }
    }
}
