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
    private var favoriteButton: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeViews()
        layoutConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    override var isSelected: Bool {
//        didSet { update() }
//    }
    
    func setup(with model: UIModel) {
        symbolImageView.image = model.image
        titleLabel.text = model.name
    }
    
//    private func update() {
//        backgroundColor = isSelected ? UIColor.contrastBlue : .styleGrey20
//        titleLabel.textColor = isSelected ? UIColor.styleWhite : .styleBlack
//        if isSelected {
//            imageView.setImageMaskColor(.styleWhite)
//        } else {
//            imageView.setImageMaskColor(.styleBlack)
//        }
//    }
}

// MARK: - LAYOUT
extension CategoryCell {
    private func initializeViews() {        
        dropCorner(Constants.cornerRadius)
        
        overlay.backgroundColor = .mainOrange.withAlphaComponent(Constants.overlayAlpha)
        
        backgroundImageView = .init(image: .named("symbol-background"))
        backgroundImageView.contentMode = .scaleToFill
        
        favoriteButton = .init(image: .named("icon-30-favorite"))
        favoriteButton.contentMode = .scaleAspectFit
        
        symbolImageView.contentMode = .scaleAspectFit
        
        titleLabel = .init(
            with: .bodyBalsamiqBold,
            textColor: .styleWhite,
            textAlignment: .center
        )
        
        contentView.addSubview(backgroundImageView)
        contentView.addSubview(symbolImageView)
        contentView.addSubview(favoriteButton)
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
        
        favoriteButton.layout {
            $0.top == contentView.topAnchor + 10
            $0.trailing == contentView.trailingAnchor - 12
            $0.height |=| Constants.favoriteImageViewSize.height
            $0.width |=| Constants.favoriteImageViewSize.width
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

// MARK: - MODEL
extension CategoryCell {
    struct UIModel {
        let image: UIImage?
        let name: String
    }
}
