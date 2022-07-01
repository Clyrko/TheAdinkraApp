import AdinkraAppUI
import AdinkraAppMLModel
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        UIFont.register()
//        applicationDIProvider.initialize()
        setupWindow()
        return true
    }
    
    private func setupWindow() {
        window = UIWindow()
        let controller = applicationDIProvider.makeApplicationBaseViewController()
//        let controller = applicationDIProvider.makeHomeViewController()
        applicationDIProvider.setBase(viewController: controller, window: window)
    }
}

//MARK: - Notification
extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions
        ) -> Void
    ) {
        completionHandler(.sound)
    }
}
