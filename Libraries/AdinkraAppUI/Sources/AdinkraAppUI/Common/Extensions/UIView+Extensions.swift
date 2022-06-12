import UIKit

extension UIView{
    
    public func dropShadow(_ radius:CGFloat = 2.0, color:UIColor = .black, _ opacity:Float = 0.4, _ offset:CGSize = .init(width: .zero, height: 4)){
        layer.shadowRadius = radius
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offset
    }
    
    public func dropCorner(_ radius:CGFloat = 3.0){
        layer.cornerRadius = radius
    }
    
    public func pinAllSides()->[NSLayoutConstraint]{
        guard let superview = superview else {fatalError("Pinning must be done in a superview")}
        return [
            topAnchor.constraint(equalTo: superview.topAnchor),
            leftAnchor.constraint(equalTo: superview.leftAnchor),
            rightAnchor.constraint(equalTo: superview.rightAnchor),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor)
        ]
    }
    
    public func roundCorners(_ corners: CACornerMask, radius: CGFloat) {
        if #available(iOS 11, *) {
            self.layer.cornerRadius = radius
            self.layer.maskedCorners = corners
        } else {
            var cornerMask = UIRectCorner()
            if(corners.contains(.layerMinXMinYCorner)){
                cornerMask.insert(.topLeft)
            }
            if(corners.contains(.layerMaxXMinYCorner)){
                cornerMask.insert(.topRight)
            }
            if(corners.contains(.layerMinXMaxYCorner)){
                cornerMask.insert(.bottomLeft)
            }
            if(corners.contains(.layerMaxXMaxYCorner)){
                cornerMask.insert(.bottomRight)
            }
            let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: cornerMask, cornerRadii: CGSize(width: radius, height: radius))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            self.layer.mask = mask
        }
    }
    
    public func layout(_ invalidatePrevious:Bool = false,using closure:(LayoutProxy) -> Void){
        if invalidatePrevious{removeConstraints(self.constraints)}
        translatesAutoresizingMaskIntoConstraints = false
        closure(LayoutProxy(view:self))
    }
    
    public func pintToAllSidesOf(_ superView:UIView, insets:UIEdgeInsets = .zero){
        layout{
            $0.leading == superView.leadingAnchor + insets.left
            $0.trailing == superView.trailingAnchor - insets.right
            $0.bottom == superView.bottomAnchor - insets.bottom
            $0.top == superView.topAnchor + insets.top
        }
    }
    
    public func borderlize(width:CGFloat = 1, color:UIColor){
        layer.borderWidth = width
        layer.borderColor = color.cgColor
    }
}



