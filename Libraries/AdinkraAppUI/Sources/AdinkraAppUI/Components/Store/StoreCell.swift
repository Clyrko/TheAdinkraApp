import UIKit

private enum Constants {
    static let containerSize = CGSize(width: 175, height: 175)
    static let itemImageViewSize = CGSize(width: 80, height: 80)
    static let cornerRadius: CGFloat = 20
    static let shadowRadius: CGFloat = 4
    static let shadowOpacity: Float = 0.80
}

class StoreCell: UICollectionViewCell {
    private var container = UIView()
    private var itemImageView = UIImageView()
    private var titleLabel: StyleLabel!
    private var priceLabel: StyleLabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeViews()
        layoutConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(with model: UIModel) {
        itemImageView.image = model.item
        titleLabel.text = model.title
        priceLabel.text = model.price
    }
}

// MARK: - LAYOUT
extension StoreCell {
    private func initializeViews() {
        container.dropCorner(Constants.cornerRadius)
        container.borderlize(width: 1, color: .styleGray)
        container.dropShadow(Constants.shadowRadius, color: .styleGray, Constants.shadowOpacity, .zero)
        
        itemImageView.contentMode = .scaleAspectFit
        
        titleLabel = .init(
            with: .header2,
            textColor: .mainOrange,
            textAlignment: .left
        )
        
        priceLabel = .init(
            with: .bodyMainRegular,
            textColor: .styleBlack,
            textAlignment: .left
        )
        
        contentView.addSubview(container)
        container.addSubview(itemImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(priceLabel)
    }
    
    private func layoutConstraints() {
        container.layout {
            $0.top == contentView.topAnchor + 5
            $0.leading == contentView.leadingAnchor + 5
            $0.trailing == contentView.trailingAnchor - 5
            $0.height |=| Constants.containerSize.height
        }
        
        itemImageView.layout {
            $0.top == container.topAnchor + 20
            $0.leading == container.leadingAnchor + 20
            $0.trailing == container.trailingAnchor - 20
            $0.bottom == container.bottomAnchor - 20
        }
        
        titleLabel.layout {
            $0.top == container.bottomAnchor + 10
            $0.leading == container.leadingAnchor
            $0.trailing == container.trailingAnchor
        }
        
        priceLabel.layout {
            $0.top == titleLabel.bottomAnchor
            $0.leading == container.leadingAnchor
            $0.trailing == container.trailingAnchor
            $0.bottom == contentView.bottomAnchor
        }
    }
}

//MARK: - Model
extension StoreCell {
    struct UIModel {
        var item: UIImage?
        var title: String
        var price: String
    }
}
