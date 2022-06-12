import UIKit


public extension UIApplication {
    var appKeyWindow: UIWindow? {
        windows.first(where: \.isKeyWindow)
    }
}
