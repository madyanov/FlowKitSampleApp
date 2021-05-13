import FlowKit

extension FlowAction {
    func success(_ completion: @escaping (Output) -> Void) {
        complete {
            switch $0 {
            case .success(let output):
                completion(output)
            case .failure:
                break
            }
        }
    }

    func failure(_ completion: @escaping (Error) -> Void) {
        complete {
            switch $0 {
            case .success:
                break
            case .failure(let error):
                completion(error)
            }
        }
    }
}
