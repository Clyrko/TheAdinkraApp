import UIKit

extension UIColor {
    class var styleWhite: UIColor {
        .init(named: "style-white", in: .module, compatibleWith: nil)!
    }
    
    class var solidBlack: UIColor {
        return .init(red: .zero, green: .zero, blue: .zero, alpha: 1)
    }
    
    class var styleBlack: UIColor {
        .init(named: "styleBlack", in: .module, compatibleWith: nil)!
    }
    
    class var mainOrange: UIColor {
        .init(named: "main-orange", in: .module, compatibleWith: nil)!
    }
}

