import UIKit

private enum Constants {
    static let leadingInset: CGFloat = 30
    static let buttonSize = CGSize(width: 24, height: 24)
    static let height: CGFloat = UIDevice.hasNotch ? 100 : 80
}


class PopOverNavigationBar: UIView {
    let backButton = UIButton()
    
    var onBackAction: Closure.Block?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeView()
        layoutConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @objc private func onTapAction(sender: UIControl){
        self.onBackAction?()
    }
}

extension PopOverNavigationBar {
    private func initializeView(){
        backgroundColor = .clear
        
        backButton.setImage(.named("icon-24-arrow-left").withRenderingMode(.alwaysTemplate), for: .normal)
        backButton.contentMode = .scaleAspectFit
        backButton.imageView?.tintColor = .mainOrange
        backButton.addTarget(self, action: #selector(onTapAction(sender:)), for: .touchUpInside)
        
        addSubview(backButton)
    }
    
    private func layoutConstraint(){
        layout {
            $0.height |=| Constants.height
        }

        backButton.layout {
            $0.leading == leadingAnchor + Constants.leadingInset
            $0.bottom == bottomAnchor - 10
            $0.width |=| Constants.buttonSize.width
            $0.height |=| Constants.buttonSize.height
        }
    }
}
