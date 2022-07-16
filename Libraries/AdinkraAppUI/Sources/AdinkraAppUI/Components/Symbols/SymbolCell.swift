import UIKit

private enum Constants {
    static let symbolImageViewSize = CGSize(width: 80, height: 80)
    static let favoriteImageViewSize = CGSize(width: 30, height: 30)
    static let cornerRadius: CGFloat = 8
}

class SymbolCell: UICollectionViewCell {
    private var backgroundImageView: UIImageView!
    private var symbolImageView = UIImageView()
    private var favoriteButton = UIButton()
    
    var onFavoriteAction: Closure.Block?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeViews()
        layoutConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func onTap(){
        self.favoriteButton.isSelected.toggle()
        onFavoriteAction?()
    }
    
    func setup(with symbol: SymbolPresentationModel) {
        symbolImageView.image = symbol.symbol
        favoriteButton.isSelected = symbol.isFavorite
    }
}

// MARK: - LAYOUT
extension SymbolCell {
    private func initializeViews() {
        dropCorner(Constants.cornerRadius)
        
        backgroundImageView = .init(image: .named("symbol-background"))
        backgroundImageView.contentMode = .scaleToFill
        
        favoriteButton.setImage(.init(systemName: "suit.heart"), for: .normal)
        favoriteButton.setImage(.init(systemName: "suit.heart.fill"), for: .selected)
        favoriteButton.tintColor = .mainOrange
        favoriteButton.addTarget(self, action: #selector(onTap), for: .touchUpInside)
        favoriteButton.isHidden = true
        
        symbolImageView.contentMode = .scaleAspectFit
        
        contentView.addSubview(backgroundImageView)
        contentView.addSubview(symbolImageView)
        contentView.addSubview(favoriteButton)
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
    }
}
