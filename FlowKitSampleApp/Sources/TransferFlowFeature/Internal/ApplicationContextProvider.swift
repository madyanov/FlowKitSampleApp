import UIKit
import FlowKit

final class ApplicationContextProvider: ContextProvider {
    var context: Context {
        let navigationController = UIApplication.shared.keyWindow?.rootViewController as? UINavigationController
        return Context(value: navigationController?.visibleViewController)
    }
}
