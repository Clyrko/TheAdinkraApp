import AdinkraAppUI
import UIKit
import CoreML
import Vision

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        UIFont.register()
        setupAdinkraModel()
        setupWindow()
        return true
    }
    
    private func setupAdinkraModel() {
        do {
            let model = try VNCoreMLModel(for: AdinkraAppObjectDetectionOne(configuration: MLModelConfiguration()).model)
            applicationDIProvider.adinkraModel = model
        } catch {
            print("ERROR OCCURED INITIAZING \(error.localizedDescription)")
        }
    }
    
    private func setupWindow() {
        window = UIWindow()
        let controller = applicationDIProvider.makeApplicationBaseViewController()
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
