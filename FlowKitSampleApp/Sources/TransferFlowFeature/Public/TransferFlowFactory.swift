import NavigationKit

public final class TransferFlowFactory {
    private let navigationDriver: NavigationDriver

    public init(navigatinDriver: NavigationDriver) {
        self.navigationDriver = navigatinDriver
    }

    public func makeTransferFlow() -> TransferFlow {
        let moduleBuilder = ModuleBuilder()
        let navigator = Navigator(driver: navigationDriver, builder: moduleBuilder)
        let transfersRepository = TransfersRepository()
        let dependencies = TransferFlowDependencies(navigator: navigator,
                                                    transfersRepository: transfersRepository)
        return TransferFlow(dependencies: dependencies)
    }
}
