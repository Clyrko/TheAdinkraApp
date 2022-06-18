import UIKit

private enum Constants {
    static let profileImageViewSize = CGSize(width: 124, height: 124)
    static let verticalInset: CGFloat = 20
}

class ProfileHeader: UITableViewHeaderFooterView {
    private var profileImageView: UIImageView!
    
    var onProfilePressed: Closure.Block?
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        initializeViews()
        layoutConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ProfileHeader {
    private func initializeViews() {
        profileImageView = .init(image: .named("profile-40-home"))
        profileImageView.contentMode = .scaleAspectFit
        
        
        addSubview(profileImageView)
    }
    
    private func layoutConstraints() {
        profileImageView.layout {
            $0.centerX == centerXAnchor
            $0.top == topAnchor + Constants.verticalInset
            $0.bottom == bottomAnchor - Constants.verticalInset
            $0.height |=| Constants.profileImageViewSize.height
            $0.width |=| Constants.profileImageViewSize.width
        }
    }
}
