public struct FlowAction<Output> {
    public typealias Completion = (Result<Output, Error>) -> Void

    let work: (@escaping Completion) -> Void

    public init(work: @escaping (@escaping Completion) -> Void) {
        self.work = work
    }
}
