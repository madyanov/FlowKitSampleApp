public struct AnyFlowNode<Input, Output> {
    private let box: AbstractFlowNodeBox<Input, Output>

    init<Node: FlowNode>(_ node: Node) where Node.Input == Input, Node.Output == Output {
        if let erased = node as? AnyFlowNode<Input, Output> {
            box = erased.box
        } else {
            box = FlowNodeBox(node)
        }
    }
}

extension AnyFlowNode: FlowNode {
    public func action(with input: Input) -> FlowAction<Output> {
        return box.action(with: input)
    }
}

// type-erasure using virtual dispatching
private class AbstractFlowNodeBox<Input, Output>: FlowNode {
    func action(with: Input) -> FlowAction<Output> {
        fatalError("Calling an abstract method with no implementation")
    }
}

private final class FlowNodeBox<Node: FlowNode>: AbstractFlowNodeBox<Node.Input, Node.Output> {
    private let node: Node

    init(_ node: Node) {
        self.node = node
    }

    override func action(with input: Input) -> FlowAction<Output> {
        return node.action(with: input)
    }
}
