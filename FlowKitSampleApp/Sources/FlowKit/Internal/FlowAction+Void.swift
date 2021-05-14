extension FlowAction {
    func void() -> FlowAction<Void> {
        return FlowAction<Void> { completion in
            complete { completion($0.map { _ in () }) }
        }
    }
}
