import UIKit

private enum Constants {
    static let horizontalInset: CGFloat = 24
    static let verticalInset: CGFloat = 24
}

class ProfileSectionTitleHeader: UIView {
    private var titleLabel: StyleLabel!

    var title: String? {
        didSet { titleLabel.text = title }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeView()
        addConstraint()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ProfileSectionTitleHeader {
    private func initializeView() {
        titleLabel = .init(
            with: .header2,
            textColor: .mainOrange,
            textAlignment: .left
        )

        addSubview(titleLabel)
    }

    private func addConstraint() {
        titleLabel.layout {
            $0.top == topAnchor + Constants.verticalInset
            $0.leading == leadingAnchor + Constants.horizontalInset
            $0.bottom == bottomAnchor - Constants.verticalInset.halved
        }
    }
}
