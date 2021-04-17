public protocol VoidFlowNode {
    func makeAction() -> FlowAction<Void>
}
