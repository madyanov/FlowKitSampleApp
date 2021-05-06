public final class Publisher<Output> {
    private enum State {
        case pending
        case fulfilled(Output)

        var value: Output? {
            switch self {
            case .fulfilled(let value):
                return value
            case .pending:
                return nil
            }
        }
    }

    public var value: Output? {
        get { state.value }
        set {
            state = newValue.map { .fulfilled($0) } ?? .pending
            subscribers.forEach { notify($0) }
        }
    }

    private var state: State = .pending
    private var subscribers: [(Output) -> Void] = []

    public init() { }

    public func subscribe(_ subscriber: @escaping (Output) -> Void) {
        subscribers.append(subscriber)
        notify(subscriber)
    }
}

private extension Publisher {
    func notify(_ subscriber: (Output) -> Void) {
        value.map { subscriber($0) }
    }
}
