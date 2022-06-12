import UIKit

extension UIImage {
    class func named(_ string: String) -> UIImage {
        .init(named: string, in: .module, with: nil)!
    }
}
