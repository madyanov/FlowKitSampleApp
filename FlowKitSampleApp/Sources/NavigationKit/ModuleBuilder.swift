import UIKit

public protocol ModuleBuilder {
    associatedtype Route

    func build(by: Route) -> UIViewController
}
