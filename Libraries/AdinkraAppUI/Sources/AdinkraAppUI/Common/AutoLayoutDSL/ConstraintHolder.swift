import UIKit

public struct ConstraintHolder {
    
    public var leading: NSLayoutConstraint?
    public var trailing: NSLayoutConstraint?
    public var bottom: NSLayoutConstraint?
    public var top: NSLayoutConstraint?
    public var height: NSLayoutConstraint?
    public var width: NSLayoutConstraint?
    public var centerY: NSLayoutConstraint?
    public var centerX: NSLayoutConstraint?
    
    public init(
        leading: NSLayoutConstraint? = nil,
        trailing: NSLayoutConstraint? = nil,
        bottom: NSLayoutConstraint? = nil,
        top: NSLayoutConstraint? = nil,
        height: NSLayoutConstraint? = nil,
        width: NSLayoutConstraint? = nil,
        centerY: NSLayoutConstraint? = nil,
        centerX: NSLayoutConstraint? = nil
    ) {
        self.leading = leading
        self.trailing = trailing
        self.bottom = bottom
        self.top = top
        self.height = height
        self.width = width
        self.centerY = centerY
        self.centerX = centerX
    }
    
    public func deactivate(){
        leading?.isActive = false
        trailing?.isActive = false
        bottom?.isActive = false
        top?.isActive = false
        height?.isActive = false
        width?.isActive = false
        centerY?.isActive = false
        centerX?.isActive = false
    }
    
    public func activate() {
        leading?.isActive = true
        trailing?.isActive = true
        bottom?.isActive = true
        top?.isActive = true
        height?.isActive = true
        width?.isActive = true
        centerY?.isActive = true
        centerX?.isActive = true
    }
}
