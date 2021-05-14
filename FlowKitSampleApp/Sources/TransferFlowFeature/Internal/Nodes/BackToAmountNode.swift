import FlowKit

protocol BackToAmountNodeDependencies {
    var navigator: RouteNavigator { get }
}

struct BackToAmountNode: FlowNode {
    typealias Input = Void
    typealias Output = TemporaryTransferWithTariff

    private let dependencies: BackToAmountNodeDependencies

    init(_ dependencies: BackToAmountNodeDependencies) {
        self.dependencies = dependencies
    }

    func action(with: Input) -> FlowAction<Output> {
        return FlowAction { _ in
            dependencies.navigator.back(to: 1)
        }
    }
}
