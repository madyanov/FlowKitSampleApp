import NavigationKit

public final class TransferFlowFactory {
    private let navigationDriver: NavigationDriver

    public init(navigatinDriver: NavigationDriver) {
        self.navigationDriver = navigatinDriver
    }

    public func makeTransferFlow() -> TransferFlow {
        let moduleBuilder = ModuleBuilder()
        let navigator = Navigator(driver: navigationDriver, builder: moduleBuilder)
        let transferRepository = RandomTransferRepository()
        let dependencies = TransferFlowDependencies(navigator: navigator,
                                                    transferRepository: transferRepository)
        return TransferFlow(dependencies: dependencies)
    }
}
