import FlowKit
import NavigationKit

protocol ShowInvalidAmountDependencies {
    var navigator: Navigator<Route, ModuleBuilder> { get }
}

struct ShowInvalidAmountNode: FlowNode {
    private let dependencies: ShowInvalidAmountDependencies

    init(_ dependencies: ShowInvalidAmountDependencies) {
        self.dependencies = dependencies
    }

    func makeAction(with: Void) -> FlowAction<Void> {
        return FlowAction<Void> { completion in
            dependencies.navigator.forward(to: .invalidAmount)
        }
    }
}
