import UIKit
import AppFeature

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    let app = App()

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        app.launch()

        return true
    }
}
