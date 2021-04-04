public func zip<V1, V2>(_ p1: Promise<V1>, _ p2: Promise<V2>) -> Promise<(V1, V2)> {
    return Promise<(V1, V2)> { completion in
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

        p1.complete { r1 = $0; zip() }
        p2.complete { r2 = $0; zip() }
    }
}

public func zip<V1, V2, V3>(_ p1: Promise<V1>, _ p2: Promise<V2>, _ lp: Promise<V3>) -> Promise<(V1, V2, V3)> {
    return Promise<(V1, V2, V3)> { completion in
        let zp = zip(p1, p2)

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

        zp.complete { zr = $0; zip() }
        lp.complete { lr = $0; zip() }
    }
}

public func zip<V1, V2, V3, V4>(_ p1: Promise<V1>,
                                _ p2: Promise<V2>,
                                _ p3: Promise<V3>,
                                _ lp: Promise<V4>) -> Promise<(V1, V2, V3, V4)> {

    return Promise<(V1, V2, V3, V4)> { completion in
        let zp = zip(p1, p2, p3)

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

        zp.complete { zr = $0; zip() }
        lp.complete { lr = $0; zip() }
    }
}

public func zip<V1, V2, V3, V4, V5>(_ p1: Promise<V1>,
                                    _ p2: Promise<V2>,
                                    _ p3: Promise<V3>,
                                    _ p4: Promise<V4>,
                                    _ lp: Promise<V5>) -> Promise<(V1, V2, V3, V4, V5)> {

    return Promise<(V1, V2, V3, V4, V5)> { completion in
        let zp = zip(p1, p2, p3, p4)

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

        zp.complete { zr = $0; zip() }
        lp.complete { lr = $0; zip() }
    }
}
