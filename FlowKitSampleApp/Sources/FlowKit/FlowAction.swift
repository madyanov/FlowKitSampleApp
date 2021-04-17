public struct FlowAction<Value> {
    let work: (@escaping (Result<Value, Error>) -> Void) -> Void

    public init(work: @escaping (@escaping (Result<Value, Error>) -> Void) -> Void) {
        self.work = work
    }
}
