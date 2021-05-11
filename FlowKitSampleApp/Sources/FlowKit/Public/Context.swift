public struct Context {
    weak var value: AnyObject?

    public init(value: AnyObject?) {
        self.value = value
    }
}
