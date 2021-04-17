public func zip<V1, V2>(_ a1: FlowAction<V1>, _ a2: FlowAction<V2>) -> FlowAction<(V1, V2)> {
    return FlowAction<(V1, V2)> { completion in
        var r1: Result<V1, Error>?
        var r2: Result<V2, Error>?

        let zip = {
            do {
                if let v1 = try r1?.get(), let v2 = try r2?.get() {
                    completion(.success((v1, v2)))
                }
            } catch {
                completion(.failure(error))
            }
        }

        a1.complete { r1 = $0; zip() }
        a2.complete { r2 = $0; zip() }
    }
}

public func zip<V1, V2, V3>(_ a1: FlowAction<V1>,
                            _ a2: FlowAction<V2>,
                            _ la: FlowAction<V3>) -> FlowAction<(V1, V2, V3)> {

    return FlowAction<(V1, V2, V3)> { completion in
        let za = zip(a1, a2)

        var zr: Result<(V1, V2), Error>?
        var lr: Result<V3, Error>?

        let zip = {
            do {
                if let zv = try zr?.get(), let lv = try lr?.get() {
                    completion(.success((zv.0, zv.1, lv)))
                }
            } catch {
                completion(.failure(error))
            }
        }

        za.complete { zr = $0; zip() }
        la.complete { lr = $0; zip() }
    }
}

public func zip<V1, V2, V3, V4>(_ a1: FlowAction<V1>,
                                _ a2: FlowAction<V2>,
                                _ a3: FlowAction<V3>,
                                _ la: FlowAction<V4>) -> FlowAction<(V1, V2, V3, V4)> {

    return FlowAction<(V1, V2, V3, V4)> { completion in
        let za = zip(a1, a2, a3)

        var zr: Result<(V1, V2, V3), Error>?
        var lr: Result<V4, Error>?

        let zip = {
            do {
                if let zv = try zr?.get(), let lv = try lr?.get() {
                    completion(.success((zv.0, zv.1, zv.2, lv)))
                }
            } catch {
                completion(.failure(error))
            }
        }

        za.complete { zr = $0; zip() }
        la.complete { lr = $0; zip() }
    }
}

public func zip<V1, V2, V3, V4, V5>(_ a1: FlowAction<V1>,
                                    _ a2: FlowAction<V2>,
                                    _ a3: FlowAction<V3>,
                                    _ a4: FlowAction<V4>,
                                    _ la: FlowAction<V5>) -> FlowAction<(V1, V2, V3, V4, V5)> {

    return FlowAction<(V1, V2, V3, V4, V5)> { completion in
        let za = zip(a1, a2, a3, a4)

        var zr: Result<(V1, V2, V3, V4), Error>?
        var lr: Result<V5, Error>?

        let zip = {
            do {
                if let zv = try zr?.get(), let lv = try lr?.get() {
                    completion(.success((zv.0, zv.1, zv.2, zv.3, lv)))
                }
            } catch {
                completion(.failure(error))
            }
        }

        za.complete { zr = $0; zip() }
        la.complete { lr = $0; zip() }
    }
}
