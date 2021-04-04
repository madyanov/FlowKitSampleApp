extension Promise {
    public func `catch`(_ completion: @escaping (Error) -> VoidPromiseBuilder?) -> Finalizer<Value>  {
        let promise = Promise { finally in
            complete {
                switch $0 {
                case .success(let value):
                    finally(.success(value))
                case .failure(let error):
                    if let builder = completion(error) {
                        builder.build().complete { _ in finally(.failure(error)) }
                    } else {
                        finally(.failure(error))
                    }
                }
            }
        }

        return Finalizer(promise: promise)
    }
}
