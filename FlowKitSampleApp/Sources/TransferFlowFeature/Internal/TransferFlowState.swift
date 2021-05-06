import PromiseKit

struct TransferFlowState {
    let loading = Publisher<Bool>()
    let tariff = Publisher<Tariff>()
}
