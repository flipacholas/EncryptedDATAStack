import UIKit
import CoreData
import EncryptedDATAStack

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow? = {
        let window = UIWindow(frame: UIScreen.main.bounds)

        return window
        }()

    var dataStack: EncryptedDATAStack = {
        let dataStack = EncryptedDATAStack(modelName: "DemoSwift", hashKey: "grampaPass")

        return dataStack
        }()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        if let window = self.window {
            let viewController = ViewController(dataStack: self.dataStack)
            window.rootViewController = UINavigationController(rootViewController: viewController)
            window.makeKeyAndVisible()
        }
        
        return true
    }
}
