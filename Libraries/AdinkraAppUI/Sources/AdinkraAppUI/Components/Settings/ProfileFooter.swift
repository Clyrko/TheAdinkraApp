import UIKit

private enum Constants {
    static let buttonHeight: CGFloat = 48
    static let verticalInset: CGFloat = 40
    static let horizontalInset: CGFloat = 40
    static let cornerRadius: CGFloat = 8
}

class ProfileFooter: UITableViewHeaderFooterView {
    private var saveButton: StyleButton!
    
    var onSavePressed: Closure.Block?
    
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

extension ProfileFooter {
    private func initializeViews() {
        saveButton = .init(with: .primaryDefault, title: "Save Changes")
        saveButton.dropCorner(Constants.cornerRadius)
        saveButton.backgroundColor = .systemTeal
        saveButton.titleColor = .styleWhite
        saveButton.onTapAction = { [weak self] in
            self?.onSavePressed?()
        }        
        
        addSubview(saveButton)
    }
    
    private func layoutConstraints() {
        saveButton.layout {
            $0.top == topAnchor + Constants.verticalInset
            $0.leading == leadingAnchor + Constants.horizontalInset
            $0.trailing == trailingAnchor - Constants.horizontalInset
            $0.bottom == bottomAnchor - Constants.verticalInset
            $0.height |=| Constants.buttonHeight
        }
    }
}
