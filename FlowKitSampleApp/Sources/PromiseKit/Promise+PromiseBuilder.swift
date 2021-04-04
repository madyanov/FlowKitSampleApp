extension Promise: PromiseBuilder {
    public func build(with: Void) -> Promise<Value> {
        return self
    }
}
