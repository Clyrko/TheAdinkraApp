import Foundation
import UIKit

private enum Constants {
    static let notificationSwitchSize = CGSize(width: 60, height: 25)
    static let horizontalInset: CGFloat = 27
    static let notificationSwitchTopInset: CGFloat = 40
    static let labelLeadingInset: CGFloat = 38
    static let editControlTopInset: CGFloat = 30
    static let editControlHeight: CGFloat = 40
    static let editLabelLeadingInset: CGFloat = 11
}

class SettingsViewController: BaseViewController {
    private var pageHeader = TitleHeaderView()
    private var notificationLabel: StyleLabel!
    private var notificationSwitch: UISwitch!
    private var editDetailsControl = UIControl()
    private var editDetailsLabel: StyleLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .styleWhite
        initializeView()
        layoutConstraint()
    }
    
    @objc private func onTapAction(sender: UIControl){
        self.showProfileScreen()
    }
    
    private func showProfileScreen() {
        let controller = applicationDIProvider.makeProfileViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
}

//MARK: - LAYOUT
extension SettingsViewController {
    private func initializeView() {
        pageHeader.title = "Settings"
        
        notificationLabel = .init(
            with: .bodyMainRegular,
            textColor: .styleBlack,
            textAlignment: .left,
            text: "Turn off notifications"
        )
        
        editDetailsLabel = .init(
            with: .bodyMainRegular,
            textColor: .styleBlack,
            textAlignment: .left,
            text: "Edit Profile Details"
        )
        
        notificationSwitch = .init()
        notificationSwitch.onTintColor = .mainOrange
        notificationSwitch.thumbTintColor = .styleWhite
        
        editDetailsControl.addTarget(self, action: #selector(onTapAction(sender:)), for: .touchUpInside)
        
        view.addSubview(pageHeader)
        view.addSubview(notificationLabel)
        view.addSubview(notificationSwitch)
        view.addSubview(editDetailsControl)
        editDetailsControl.addSubview(editDetailsLabel)
    }
    
    private func layoutConstraint() {
        pageHeader.layout {
            $0.top == view.topAnchor
            $0.leading == view.leadingAnchor
            $0.trailing == view.trailingAnchor
        }
        
        notificationSwitch.layout {
            $0.top == pageHeader.bottomAnchor + Constants.notificationSwitchTopInset
            $0.trailing == view.trailingAnchor - Constants.horizontalInset
            $0.height |=| Constants.notificationSwitchSize.height
            $0.width |=| Constants.notificationSwitchSize.width
        }
        
        notificationLabel.layout {
            $0.centerY == notificationSwitch.centerYAnchor
            $0.leading == view.leadingAnchor + Constants.labelLeadingInset
        }
        
        editDetailsControl.layout {
            $0.top == notificationSwitch.bottomAnchor + Constants.editControlTopInset
            $0.leading == view.leadingAnchor + Constants.horizontalInset
            $0.trailing == view.trailingAnchor - Constants.horizontalInset
            $0.height |=| Constants.editControlHeight
        }
        
        editDetailsLabel.layout {
            $0.centerY == editDetailsControl.centerYAnchor
            $0.leading == editDetailsControl.leadingAnchor + Constants.editLabelLeadingInset
            $0.trailing == editDetailsControl.trailingAnchor
        }
    }
}
