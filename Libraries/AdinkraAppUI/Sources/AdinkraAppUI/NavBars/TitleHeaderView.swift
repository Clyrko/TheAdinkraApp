import UIKit

private enum Constants {
    static let trailingInset: CGFloat = 32
    static let buttonSize = CGSize(width: 40, height: 40)
    static let height: CGFloat = UIDevice.hasNotch ? 100 : 80
}


class TitleHeaderView: UIView {
    private var titleLabel: StyleLabel!
    private var profilePictureButton = UIButton()
    
    var title: String? {
        didSet { titleLabel.text = title }
    }
    
    var onProfileAction: Closure.Block?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeView()
        layoutConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @objc private func onTapAction(sender: UIControl){
        self.onProfileAction?()
    }
}

//MARK: - LAYOUT
extension TitleHeaderView {
    private func initializeView() {
        backgroundColor = .clear
        
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
        
        addSubview(profilePictureButton)
        addSubview(titleLabel)
    }
    
    private func layoutConstraint()
    {
        layout {
            $0.height |=| Constants.height
        }
        
        profilePictureButton.layout {
            $0.trailing == trailingAnchor - Constants.trailingInset
            $0.bottom == bottomAnchor - 10
            $0.width |=| Constants.buttonSize.width
            $0.height |=| Constants.buttonSize.height
        }
        
        titleLabel.layout {
            $0.centerY == profilePictureButton.centerYAnchor
            $0.centerX == centerXAnchor
        }
    }
}
