import Foundation
import UIKit

private enum Constants {
    static let cornerRadius: CGFloat = 8
    static let horizontalInset: CGFloat = 28
    static let verticalInset: CGFloat = 8
    static let textFieldHeight: CGFloat = 61
}

class ProfileCell: UITableViewCell {
    private var titleLabel: StyleLabel!
    private var textField = StyleTextField()
    
    override init(style: UITableViewCell.CellStyle,
                  reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initializeView()
        layoutConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(with model: UIModel) {
        titleLabel.text = model.title
        textField.placeholder = model.textField
    }
}

//MARK: - LAYOUT
extension ProfileCell {
    private func initializeView() {
        selectionStyle = .none
        
        titleLabel = .init(
            with: .header2,
            textColor: .mainOrange,
            textAlignment: .left
        )
        
        textField.textColor = .systemGray
        textField.dropCorner(Constants.cornerRadius)
        textField.iconImage = .named("icon-18-edit")
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(textField)
    }
    
    private func layoutConstraint() {
        titleLabel.layout {
            $0.top == contentView.topAnchor + Constants.verticalInset
            $0.leading == contentView.leadingAnchor + Constants.horizontalInset
            $0.trailing == contentView.trailingAnchor - Constants.horizontalInset
        }
        
        textField.layout {
            $0.top == titleLabel.bottomAnchor + Constants.verticalInset
            $0.leading == contentView.leadingAnchor + Constants.horizontalInset
            $0.trailing == contentView.trailingAnchor - Constants.horizontalInset
            $0.bottom == contentView.bottomAnchor - Constants.verticalInset
            $0.height |=| Constants.textFieldHeight
        }
    }
}

//MARK: - Model
extension ProfileCell {
    struct UIModel {
        var title: String
        var textField: String
    }
}
