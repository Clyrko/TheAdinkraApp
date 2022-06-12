import Foundation
import UIKit

private enum Constants {
    static let iconImageViewSize = CGSize(width: 315, height: 200)
    static let cornerRadius: CGFloat = 8
}

class SignUpCompleteViewController: BaseViewController {
    private var titleLabel: StyleLabel!
    private var iconImageView: UIImageView!
    private var letsGetStartedButton: StyleButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .styleWhite
        initializeView()
        layoutConstraint()
    }
}

//MARK: - LAYOUT
extension SignUpCompleteViewController {
    private func initializeView() {
        titleLabel = .init(
            with: .header2,
            textColor: .mainOrange,
            textAlignment: .center,
            text: "Account created successfully!"
        )
        
        letsGetStartedButton = .init(with: .primaryDefault, title: "Let’s get started")
        letsGetStartedButton.dropCorner(Constants.cornerRadius)
        letsGetStartedButton.canHighlight = false
        
        iconImageView = .init(image: .named("sign-up-complete-background"))
        iconImageView.contentMode = .scaleAspectFit
        
        view.addSubview(titleLabel)
        view.addSubview(iconImageView)
        view.addSubview(letsGetStartedButton)
    }
    
    private func layoutConstraint() {
        iconImageView.layout {
            $0.centerX == view.centerXAnchor
            $0.centerY == view.centerYAnchor
            $0.height |=| Constants.iconImageViewSize.height
            $0.width |=| Constants.iconImageViewSize.width
        }
        
        titleLabel.layout {
            $0.centerX == view.centerXAnchor
            $0.bottom == iconImageView.topAnchor - 53
        }
        
        letsGetStartedButton.layout {
            $0.top == iconImageView.bottomAnchor + 53
            $0.leading == view.leadingAnchor + 41
            $0.trailing == view.trailingAnchor - 41
            $0.height |=| 48
        }
    }
}
