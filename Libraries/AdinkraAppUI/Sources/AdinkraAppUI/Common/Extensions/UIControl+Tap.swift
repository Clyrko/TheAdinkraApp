import UIKit

public class TappableUIControl: UIControl {
    var onTapAction: Closure.Block?
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        addTarget(self, action: #selector(onTapAction(sender:)), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func onTapAction(sender: UIControl){
        onTapAction?()
    }
}
