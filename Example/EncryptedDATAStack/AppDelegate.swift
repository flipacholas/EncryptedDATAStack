import UIKit
import CoreData
import EncryptedDATAStack

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow? = {
        let window = UIWindow(frame: UIScreen.mainScreen().bounds)

        return window
        }()

    var dataStack: EncryptedDATAStack = {
        let dataStack = EncryptedDATAStack(modelName: "DemoSwift", hashKey: "grampaPass")

        return dataStack
        }()

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        if let window = self.window {
            let viewController = ViewController(dataStack: self.dataStack)
            window.rootViewController = UINavigationController(rootViewController: viewController)
            window.makeKeyAndVisible()
        }

        return true
    }
}
