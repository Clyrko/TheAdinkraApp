import Foundation
import UIKit

private enum Constants {
    static let horizontalInset: CGFloat = 41
    static let titleLabelTopInset: CGFloat = 185
    static let titleLabelHorizontalInset: CGFloat = 51
    static let emailTopInset: CGFloat = 50
    static let sendButtonTopInset: CGFloat = 21
    static let stackViewTopInset: CGFloat = 35
    static let cornerRadius: CGFloat = 8
    static let stackViewSpacing: CGFloat = 4
    static let buttonHeight: CGFloat = 48
    static let stackViewHeight: CGFloat = 21
}

class PasswordResetViewController: BaseViewController {
    private var titleLabel: StyleLabel!
    private var emailTextField: StyleTextField!
    private var sendButton: StyleButton!
    private var rememberPasswordLabel: StyleLabel!
    private var rememberPasswordButton: StyleButton!
    private var rememberPasswordStackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeView()
        layoutConstraint()
    }
}

//MARK: - LAYOUT
extension PasswordResetViewController {
    private func initializeView() {
        titleLabel = .init(
            with: .header3,
            textColor: .mainOrange,
            textAlignment: .center,
            text: "Enter the email address you used to create your account"
        )
        
        emailTextField.placeholder = "Email"
        emailTextField.textColor = .styleGray
        emailTextField.dropCorner(Constants.cornerRadius)
        
        sendButton = .init(with: .primaryDefault, title: "Send")
        sendButton.dropCorner(Constants.cornerRadius)
        sendButton.backgroundColor = .mainOrange
        sendButton.titleColor = .styleWhite
        
        rememberPasswordLabel = .init(
            with: .bodyMainRegular,
            textColor: .styleBlack,
            textAlignment: .left,
            text: "Remembered Password?"
        )
        
        rememberPasswordButton = .init(with: .primaryDefault, title: "Click here")
        rememberPasswordButton.dropCorner(Constants.cornerRadius)
        rememberPasswordButton.backgroundColor = .clear
        rememberPasswordButton.titleColor = .mainOrange
        
        rememberPasswordStackView = .init(arrangedSubviews: [rememberPasswordLabel, rememberPasswordButton])
        rememberPasswordStackView.axis = .horizontal
        rememberPasswordStackView.spacing = Constants.stackViewSpacing
        
        view.addSubview(titleLabel)
        view.addSubview(emailTextField)
        view.addSubview(sendButton)
        view.addSubview(rememberPasswordLabel)
        view.addSubview(rememberPasswordButton)
    }
    
    private func layoutConstraint() {
        titleLabel.layout {
            $0.top == view.topAnchor + Constants.titleLabelTopInset
            $0.leading == view.leadingAnchor + Constants.titleLabelHorizontalInset
            $0.trailing == view.trailingAnchor - Constants.titleLabelHorizontalInset
        }
        
        emailTextField.layout {
            $0.top == titleLabel.bottomAnchor + Constants.emailTopInset
            $0.leading == view.leadingAnchor + Constants.horizontalInset
            $0.trailing == view.trailingAnchor - Constants.horizontalInset
        }
        
        sendButton.layout {
            $0.top == emailTextField.bottomAnchor + Constants.sendButtonTopInset
            $0.leading == view.leadingAnchor + Constants.horizontalInset
            $0.trailing == view.trailingAnchor - Constants.horizontalInset
            $0.height |=| Constants.buttonHeight
        }
        
        rememberPasswordStackView.layout {
            $0.centerX == view.centerXAnchor
            $0.top == sendButton.bottomAnchor + Constants.stackViewTopInset
            $0.height |=| Constants.stackViewHeight
        }
    }
}
