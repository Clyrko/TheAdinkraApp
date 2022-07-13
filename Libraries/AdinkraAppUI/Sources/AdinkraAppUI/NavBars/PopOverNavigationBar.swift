import UIKit

private enum Constants {
    static let horizontalInset: CGFloat = 30
    static let buttonSize = CGSize(width: 24, height: 24)
    static let profileButtonSize = CGSize(width: 40, height: 40)
    static let height: CGFloat = UIDevice.hasNotch ? 100 : 80
}


class PopOverNavigationBar: UIView {
    let backButton = UIButton()
    private var titleLabel: StyleLabel!
    var profilePictureButton = UIButton()
    
    var onBackAction: Closure.Block?
    var onProfileAction: Closure.Block?
    
    var title: String? {
        didSet{ titleLabel.text = title }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeView()
        layoutConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @objc private func onTapAction(sender: UIControl) {
        if sender == backButton {
            self.onBackAction?()
        } else {
            self.onProfileAction?()
        }
    }
}

extension PopOverNavigationBar {
    private func initializeView(){
        backgroundColor = .clear
        
        backButton.setImage(.named("icon-24-arrow-left").withRenderingMode(.alwaysTemplate), for: .normal)
        backButton.contentMode = .scaleAspectFit
        backButton.imageView?.tintColor = .mainOrange
        backButton.addTarget(self, action: #selector(onTapAction(sender:)), for: .touchUpInside)
        
        titleLabel = .init(
            with: .bodyBalsamiqBold,
            textColor: .mainOrange,
            textAlignment: .center,
            text: title
        )
        
        profilePictureButton.setImage(.named("profile-40-home"), for: .normal)
        profilePictureButton.contentMode = .scaleAspectFit
        profilePictureButton.imageView?.tintColor = .mainOrange
        profilePictureButton.addTarget(self, action: #selector(onTapAction(sender:)), for: .touchUpInside)
        
        addSubview(backButton)
        addSubview(titleLabel)
        addSubview(profilePictureButton)
    }
    
    private func layoutConstraint(){
        layout {
            $0.height |=| Constants.height
        }

        backButton.layout {
            $0.leading == leadingAnchor + Constants.horizontalInset
            $0.bottom == bottomAnchor - 10
            $0.width |=| Constants.buttonSize.width
            $0.height |=| Constants.buttonSize.height
        }
        
        titleLabel.layout {
            $0.centerY == backButton.centerYAnchor
            $0.centerX == centerXAnchor
        }
        
        profilePictureButton.layout {
            $0.centerY == backButton.centerYAnchor
            $0.trailing == trailingAnchor - Constants.horizontalInset
            $0.width |=| Constants.profileButtonSize.width
            $0.height |=| Constants.profileButtonSize.height
        }
    }
}
