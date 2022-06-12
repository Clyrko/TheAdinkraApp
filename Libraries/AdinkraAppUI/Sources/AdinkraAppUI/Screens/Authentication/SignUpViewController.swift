import Foundation
import UIKit

private enum Constants {
    static let horizontalInset: CGFloat = 41
    static let textFieldTopInset: CGFloat = 18
    static let stackViewBottomInset: CGFloat = 33
    static let cornerRadius: CGFloat = 8
    static let stackViewSpacing: CGFloat = 4
    static let buttonHeight: CGFloat = 48
    static let stackViewHeight: CGFloat = 25
}

class SignUpViewController: UIViewController {
    private var signUpTitleLabel: StyleLabel!
    private var firstNameTextField = StyleTextField()
    private var lastNameTextField = StyleTextField()
    private var emailAddressTextField = StyleTextField()
    private var signUpButton: StyleButton!
    private var signInLabel: StyleLabel!
    private var signInButton: StyleButton!
    private var signInStackView: UIStackView!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .styleWhite
        initializeView()
        layoutConstraint()
    }
}

//MARK: - LAYOUT
extension SignUpViewController {
    private func initializeView() {
        signUpTitleLabel = .init(
            with: .headerBalsamiqRegular,
            textColor: .mainOrange,
            textAlignment: .left,
            text: "Sign Up"
        )
        
        firstNameTextField.placeholder = "First Name"
        firstNameTextField.textColor = .systemGray
        firstNameTextField.dropCorner(Constants.cornerRadius)
        
        lastNameTextField.placeholder = "Last Name"
        lastNameTextField.textColor = .systemGray
        lastNameTextField.dropCorner(Constants.cornerRadius)
        
        emailAddressTextField.placeholder = "Email"
        emailAddressTextField.textColor = .systemGray
        emailAddressTextField.dropCorner(Constants.cornerRadius)
        
        signUpButton = .init(with: .primaryDefault, title: "Sign Up")
        signUpButton.dropCorner(Constants.cornerRadius)
        signUpButton.backgroundColor = .mainOrange
        signUpButton.titleColor = .styleWhite
        
        signInLabel = .init(
            with: .bodyMainRegular,
            textColor: .styleBlack,
            textAlignment: .left,
            text: "Already have an account?"
        )
        
        signInButton = .init(with: .primaryDefault, title: "Sign In")
        signInButton.dropCorner(Constants.cornerRadius)
        signInButton.backgroundColor = .clear
        signInButton.titleColor = .mainOrange
        
        signInStackView = .init(arrangedSubviews: [signInLabel, signInButton])
        signInStackView.axis = .horizontal
        signInStackView.spacing = Constants.stackViewSpacing
        
        view.addSubview(signUpTitleLabel)
        view.addSubview(firstNameTextField)
        view.addSubview(lastNameTextField)
        view.addSubview(emailAddressTextField)
        view.addSubview(signUpButton)
        view.addSubview(signInStackView)
        
    }
    
    private func layoutConstraint() {
        signUpTitleLabel.layout {
            $0.top == view.topAnchor + 73
            $0.leading == view.leadingAnchor + 53
        }
        
        lastNameTextField.layout {
            $0.centerX == view.centerXAnchor
            $0.centerY == view.centerYAnchor
            $0.leading == view.leadingAnchor + Constants.horizontalInset
            $0.trailing == view.trailingAnchor - Constants.horizontalInset
        }
        
        firstNameTextField.layout {
            $0.bottom == lastNameTextField.topAnchor - Constants.textFieldTopInset
            $0.leading == view.leadingAnchor + Constants.horizontalInset
            $0.trailing == view.trailingAnchor - Constants.horizontalInset
        }
        
        emailAddressTextField.layout {
            $0.top == lastNameTextField.bottomAnchor + Constants.textFieldTopInset
            $0.leading == view.leadingAnchor + Constants.horizontalInset
            $0.trailing == view.trailingAnchor - Constants.horizontalInset
        }
        
        signUpButton.layout {
            $0.top == emailAddressTextField.bottomAnchor + Constants.textFieldTopInset
            $0.leading == view.leadingAnchor + Constants.horizontalInset
            $0.trailing == view.trailingAnchor - Constants.horizontalInset
            $0.height |=| Constants.buttonHeight
        }
        
        signInStackView.layout {
            $0.centerX == view.centerXAnchor
            $0.bottom == view.bottomAnchor - Constants.stackViewBottomInset
            $0.height |=| Constants.stackViewHeight
        }
    }
}
