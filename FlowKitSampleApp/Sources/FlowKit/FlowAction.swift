public struct FlowAction<Output> {
    let work: (@escaping (Result<Output, Error>) -> Void) -> Void

    public init(work: @escaping (@escaping (Result<Output, Error>) -> Void) -> Void) {
        self.work = work
    }
}
