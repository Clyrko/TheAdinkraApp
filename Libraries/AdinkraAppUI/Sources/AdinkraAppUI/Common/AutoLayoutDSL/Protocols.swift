import UIKit

public protocol LayoutAnchor {
    func constraint(equalTo anchor:Self, constant:CGFloat)->NSLayoutConstraint
    
    func constraint(greaterThanOrEqualTo anchor: Self,
                    constant: CGFloat) -> NSLayoutConstraint
    func constraint(lessThanOrEqualTo anchor: Self,
                    constant: CGFloat) -> NSLayoutConstraint
    func constraint(equalToConstant c: CGFloat) -> NSLayoutConstraint
}

extension NSLayoutAnchor:LayoutAnchor{
    @objc public func constraint(equalToConstant c: CGFloat) -> NSLayoutConstraint {
        guard let dimension = self as? NSLayoutDimension else{
            fatalError("Unable to cast to NSlayoutDimesion")
        }
        return dimension.constraint(equalToConstant: c)
    }
}


