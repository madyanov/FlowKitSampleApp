public func firstly<Builder: PromiseBuilder>(_ builder: Builder) -> Promise<Builder.Output> where Builder.Input == Void {
    return builder.build()
}
