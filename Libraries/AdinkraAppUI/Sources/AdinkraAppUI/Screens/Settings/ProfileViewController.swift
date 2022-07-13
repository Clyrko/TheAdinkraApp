import Foundation
import UIKit

private enum Constants {
    static let profileImageViewSize = CGSize(width: 124, height: 124)
}

class ProfileViewController: BaseViewController {
    private let navBar = PopOverNavigationBar()
    private var tableView: UITableView!
    
    private var profile: [ProfileCell.UIModel] = [    
        .init(title: "Full Name", textField: "Full Name"),
        .init(title: "Email Address", textField: "Email Address")
    ]
    
    private var password: [ProfileCell.UIModel] = [
        .init(title: "Current Password", textField: "***********"),
        .init(title: "New Password", textField: "***********"),
        .init(title: "Confirm New Password", textField: "***********")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .styleWhite
        initializeView()
        layoutConstraint()
    }
}

//MARK: - TABLEVIEW
extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return .zero
        case 1:
            return profile.count
        case 2:
            return password.count
        default:
            return .zero
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            return UITableViewCell()
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileCell.Identifier, for: indexPath) as? ProfileCell else { fatalError() }
            cell.setup(with: profile[indexPath.row])
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileCell.Identifier, for: indexPath) as? ProfileCell else { fatalError() }
            cell.setup(with: password[indexPath.row])
            return cell
        default:
            return UITableViewCell()
        }
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0:
            guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: ProfileHeader.Identifier) as? ProfileHeader else { fatalError() }
            return header
        case 1:
            let header = ProfileSectionTitleHeader()
            header.title = "Personal Details"
            return header
        case 2:
            let header = ProfileSectionTitleHeader()
            header.title = "Password Details"
            return header
        default:
            return UIView()
        }
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 2 {
        guard let footer = tableView.dequeueReusableHeaderFooterView(withIdentifier: ProfileFooter.Identifier) as? ProfileFooter else { fatalError() }
        return footer
        }
        return UIView()
    }
}

//MARK: - LAYOUT
extension ProfileViewController {
    private func initializeView() {
        navBar.onBackAction = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        navBar.profilePictureButton.isHidden = true
        navBar.title = "Profile"
        
        tableView = .init(frame: .zero, style: .grouped)
        tableView.backgroundColor = .styleWhite
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.allowsMultipleSelection = true
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ProfileCell.self, forCellReuseIdentifier: ProfileCell.Identifier)
        tableView.register(ProfileHeader.self, forHeaderFooterViewReuseIdentifier: ProfileHeader.Identifier)
        tableView.register(ProfileFooter.self, forHeaderFooterViewReuseIdentifier: ProfileFooter.Identifier)
        
        view.addSubview(navBar)
        view.addSubview(tableView)
    }
    
    private func layoutConstraint() {
        navBar.layout {
            $0.top == view.topAnchor
            $0.leading == view.leadingAnchor
            $0.trailing == view.trailingAnchor
        }
        
        tableView.layout {
            $0.top == navBar.bottomAnchor
            $0.leading == view.leadingAnchor
            $0.trailing == view.trailingAnchor
            $0.bottom == view.bottomAnchor
        }
    }
}
