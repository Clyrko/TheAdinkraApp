import Foundation
import UIKit

private enum Constants {
    static let horizontalInset: CGFloat = 41
    static let cornerRadius: CGFloat = 8
    static let stackViewSpacing: CGFloat = 4
}

class SignInViewController: BaseViewController {
    private var signInTitleLabel: StyleLabel!
    private var emailTextField = StyleTextField()
    private var passwordTextField = StyleTextField()
    private var logInButton: StyleButton!
    private var forgotPasswordLabel: StyleLabel!
    private var forgotPasswordButton: StyleButton!
    private var forgotPasswordStackView: UIStackView!
    private var signUpLabel: StyleLabel!
    private var signUpButton: StyleButton!
    private var signUpStackView: UIStackView!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .styleWhite
        initializeView()
        layoutConstraint()
    }
}

//MARK: - LAYOUT
extension SignInViewController {
    private func initializeView() {
        signInTitleLabel = .init(
            with: .headerBalsamiqRegular,
            textColor: .mainOrange,
            textAlignment: .left,
            text: "Sign In"
        )
        
        emailTextField.placeholder = "Email"
        emailTextField.textColor = .systemGray
        emailTextField.dropCorner(Constants.cornerRadius)
        
        passwordTextField.placeholder = "Password"
        passwordTextField.textColor = .systemGray
        passwordTextField.dropCorner(Constants.cornerRadius)
        
        logInButton = .init(with: .primaryDefault, title: "Login")
        logInButton.dropCorner(Constants.cornerRadius)
        logInButton.backgroundColor = .mainOrange
        logInButton.titleColor = .styleWhite
        
        forgotPasswordLabel = .init(
            with: .bodyMainRegular,
            textColor: .styleBlack,
            textAlignment: .left,
            text: "Forgot Password?"
        )
        
        forgotPasswordButton = .init(with: .primaryDefault, title: "Click here")
        forgotPasswordButton.dropCorner(Constants.cornerRadius)
        forgotPasswordButton.backgroundColor = .clear
        forgotPasswordButton.titleColor = .mainOrange
        
        forgotPasswordStackView = .init(arrangedSubviews: [forgotPasswordLabel, forgotPasswordButton])
        forgotPasswordStackView.axis = .horizontal
        forgotPasswordStackView.spacing = Constants.stackViewSpacing
        
        signUpLabel = .init(
            with: .bodyMainRegular,
            textColor: .styleBlack,
            textAlignment: .left,
            text: "Don’t have an account?"
        )
        
        signUpButton = .init(with: .primaryDefault, title: "Sign Up")
        signUpButton.dropCorner(Constants.cornerRadius)
        signUpButton.backgroundColor = .clear
        signUpButton.titleColor = .mainOrange
        
        signUpStackView = .init(arrangedSubviews: [forgotPasswordLabel, forgotPasswordButton])
        signUpStackView.axis = .horizontal
        signUpStackView.spacing = Constants.stackViewSpacing
        
        view.addSubview(signInTitleLabel)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(logInButton)
        view.addSubview(forgotPasswordStackView)
        view.addSubview(signUpStackView)
    }
    
    private func layoutConstraint() {
        signInTitleLabel.layout {
            $0.top == view.topAnchor + 73
            $0.leading == view.leadingAnchor + 53
        }
        
        passwordTextField.layout {
            $0.centerX == view.centerXAnchor
            $0.centerY == view.centerYAnchor
            $0.leading == view.leadingAnchor + Constants.horizontalInset
            $0.trailing == view.trailingAnchor - Constants.horizontalInset
        }
        
        emailTextField.layout {
            $0.bottom == passwordTextField.topAnchor - 22
            $0.leading == view.leadingAnchor + Constants.horizontalInset
            $0.trailing == view.trailingAnchor - Constants.horizontalInset
        }
        
        logInButton.layout {
            $0.top == passwordTextField.bottomAnchor + 25
            $0.leading == view.leadingAnchor + Constants.horizontalInset
            $0.trailing == view.trailingAnchor - Constants.horizontalInset
            $0.height |=| 48
        }
        
        forgotPasswordStackView.layout {
            $0.centerX == view.centerXAnchor
            $0.top == logInButton.bottomAnchor + 10
        }        
        
        signUpStackView.layout {
            $0.centerX == view.centerXAnchor
            $0.bottom == view.bottomAnchor - 41
            $0.height |=| 21
        }
    }
}
