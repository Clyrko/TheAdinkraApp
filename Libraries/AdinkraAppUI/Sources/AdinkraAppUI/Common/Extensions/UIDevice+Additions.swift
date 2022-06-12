import UIKit

public extension UIDevice {
    static var hasNotch: Bool {
        let bottom = UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? .zero
        return bottom > .zero
    }
}
