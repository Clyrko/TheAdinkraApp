import UIKit

private enum Constants {
    static let symbolImageViewSize = CGSize(width: 80, height: 80)
    static let favoriteImageViewSize = CGSize(width: 30, height: 30)
    static let cornerRadius: CGFloat = 8
    static let overlayAlpha: CGFloat = 0.70
    static let overlayHeight: CGFloat = 35
}

class CategoryCell: UICollectionViewCell {
    private var backgroundImageView: UIImageView!
    private var overlay = UIView()
    private var titleLabel: StyleLabel!
    private var symbolImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeViews()
        layoutConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(with category: CategoriesPresentationModel) {
        symbolImageView.image = category.image
        titleLabel.text = category.category
    }
}

// MARK: - LAYOUT
extension CategoryCell {
    private func initializeViews() {        
        dropCorner(Constants.cornerRadius)
        
        overlay.backgroundColor = .mainOrange.withAlphaComponent(Constants.overlayAlpha)
        
        backgroundImageView = .init(image: .named("symbol-background"))
        backgroundImageView.contentMode = .scaleToFill
        
        symbolImageView.contentMode = .scaleAspectFit
        
        titleLabel = .init(
            with: .bodyBalsamiqBold,
            textColor: .styleWhite,
            textAlignment: .center
        )
        
        contentView.addSubview(backgroundImageView)
        contentView.addSubview(symbolImageView)
        contentView.addSubview(overlay)
        overlay.addSubview(titleLabel)
    }
    
    private func layoutConstraints() {
        backgroundImageView.pintToAllSidesOf(contentView)
        
        symbolImageView.layout {
            $0.centerY == contentView.centerYAnchor
            $0.centerX == contentView.centerXAnchor
            $0.height |=| Constants.symbolImageViewSize.height
            $0.width |=| Constants.symbolImageViewSize.width
        }
        
        overlay.layout {
            $0.centerY == contentView.centerYAnchor
            $0.leading == contentView.leadingAnchor
            $0.trailing == contentView.trailingAnchor
            $0.height |=| Constants.overlayHeight
        }
        
        titleLabel.layout {
            $0.centerY == overlay.centerYAnchor
            $0.centerX == overlay.centerXAnchor
            $0.leading == overlay.leadingAnchor + 12
            $0.trailing == overlay.trailingAnchor - 12
        }
    }
}
