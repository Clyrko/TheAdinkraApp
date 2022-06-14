import Foundation
import UIKit

private enum Constants {
    static let cornerRadius: CGFloat = 8
    static let horizontalInset: CGFloat = 40
    static let titleLabelHorizontalInset: CGFloat = 58
    static let titleBottomInset: CGFloat = 50
    static let buttonHeight: CGFloat = 48
}

class TemporaryPasswordViewController: BaseViewController {
    private var titleLabel: StyleLabel!
    private var goBackButton: StyleButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeView()
        layoutConstraint()
    }
}

//MARK: - LAYOUT
extension TemporaryPasswordViewController {
    private func initializeView() {
        titleLabel = .init(
            with: .header3,
            textColor: .mainOrange,
            textAlignment: .center,
            text: "Temporary password sent to your email. Kindly check and log in again."
        )
        
        goBackButton = .init(with: .primaryDefault, title: "Go Back to Login")
        goBackButton.dropCorner(Constants.cornerRadius)
        goBackButton.backgroundColor = .mainOrange
        goBackButton.titleColor = .styleWhite
        
        view.addSubview(titleLabel)
        view.addSubview(goBackButton)
    }
    
    private func layoutConstraint() {
        goBackButton.layout {
            $0.centerX == view.centerXAnchor
            $0.centerY == view.centerYAnchor
            $0.leading == view.leadingAnchor + Constants.horizontalInset
            $0.trailing == view.trailingAnchor - Constants.horizontalInset
            $0.height |=| Constants.buttonHeight
        }
        
        titleLabel.layout {
            $0.leading == view.leadingAnchor + Constants.titleLabelHorizontalInset
            $0.trailing == view.trailingAnchor - Constants.titleLabelHorizontalInset
            $0.bottom == goBackButton.topAnchor - Constants.titleBottomInset
        }
    }
}
