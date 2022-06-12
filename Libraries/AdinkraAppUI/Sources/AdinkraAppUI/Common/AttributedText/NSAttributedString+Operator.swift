import UIKit

public extension NSAttributedString {
    static func +(lhs:NSAttributedString, rhs:NSAttributedString)->NSAttributedString{
        let attr = NSMutableAttributedString(attributedString: lhs)
        attr.append(rhs)
        return attr
    }
}
