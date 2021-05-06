// Упрощенная реализация PassthroughSubject из Combine
// https://developer.apple.com/documentation/combine/passthroughsubject
public final class PassthroughSubject<Output> {
    private var subscribers: [(Output) -> Void] = []

    public func sink(_ subscriber: @escaping (Output) -> Void) {
        subscribers.append(subscriber)
    }

    public func send(_ input: Output) {
        subscribers.forEach { $0(input) }
    }
}
