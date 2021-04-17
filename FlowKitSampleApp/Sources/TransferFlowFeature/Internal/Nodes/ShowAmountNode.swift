import FlowKit

struct ShowAmountNode: FlowNode {
    func makeAction(with country: Country) -> FlowAction<Route> {
        return FlowAction<Route> { $0(.success(.amount(country: country, completion: { _ in }))) }
    }
}
