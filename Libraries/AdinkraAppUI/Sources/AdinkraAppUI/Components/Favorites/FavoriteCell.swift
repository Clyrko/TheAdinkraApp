import Foundation
import UIKit

private enum Constants {
    static let symbolImageViewSize = CGSize(width: 85, height: 85)
    static let favoriteButtonSize = CGSize(width: 40, height: 40)
    static let insets = UIEdgeInsets(top: 12, left: 30, bottom: 12, right: 30)
    static let symbolInsets = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    static let cornerRadius: CGFloat = 8
    static let verticalInset: CGFloat = 8
    static let horizontalInset: CGFloat = 16
}

class FavoriteCell: UITableViewCell {
    private var container = UIView()
    private var symbolContainer = UIView()
    private var backgroundImageView: UIImageView!
    private var symbolImageView = UIImageView()
    private var titleLabel: StyleLabel!
    private var descriptionLabel: StyleLabel!
    private var viewDetailsButton: StyleButton!
    private var favoriteButton = UIButton()
    
    override init(style: UITableViewCell.CellStyle,
                  reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initializeView()
        layoutConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func onTap(){
        self.favoriteButton.isSelected.toggle()
    }
    
    func setup(with symbol: SymbolPresentationModel) {
        symbolImageView.image = symbol.symbol
        titleLabel.text = symbol.title
        descriptionLabel.text = symbol.description
    }
}

//MARK: - LAYOUT
extension FavoriteCell {
    private func initializeView() {
        selectionStyle = .none
        
        symbolContainer.dropCorner(Constants.cornerRadius)
        symbolContainer.isUserInteractionEnabled = false
        
        backgroundImageView = .init(image: .named("symbol-background"))
        backgroundImageView.contentMode = .scaleToFill
        
        symbolImageView.contentMode = .scaleAspectFit
        
        favoriteButton.setImage(.init(systemName: "suit.heart"), for: .normal)
        favoriteButton.setImage(.init(systemName: "suit.heart.fill"), for: .selected)
        favoriteButton.tintColor = .mainOrange
        favoriteButton.isSelected = true
        favoriteButton.addTarget(self, action: #selector(onTap), for: .touchUpInside)
        
        titleLabel = .init(
            with: .header1,
            textColor: .mainOrange,
            textAlignment: .left
        )
        
        descriptionLabel = .init(
            with: .bodyMainRegular,
            textColor: .styleBlack,
            textAlignment: .left
        )
        
        viewDetailsButton = .init(with: .primaryDefault, title: "view details")
        viewDetailsButton.backgroundColor = .clear
        viewDetailsButton.canHighlight = false
        viewDetailsButton.titleColor = .mainOrange
        
        contentView.addSubview(container)
        container.addSubview(symbolContainer)
        symbolContainer.addSubview(backgroundImageView)
        symbolContainer.addSubview(symbolImageView)
        container.addSubview(titleLabel)
        container.addSubview(descriptionLabel)
        container.addSubview(favoriteButton)
        container.addSubview(viewDetailsButton)
    }
    
    private func layoutConstraint() {
        container.pintToAllSidesOf(contentView, insets: Constants.insets)
        
        symbolContainer.layout {
            $0.top == container.topAnchor
            $0.leading == container.leadingAnchor
            $0.bottom == container.bottomAnchor
        }
        
        backgroundImageView.pintToAllSidesOf(symbolContainer)
        
        symbolImageView.pintToAllSidesOf(symbolContainer, insets: Constants.symbolInsets)
        
        symbolImageView.layout {
            $0.height |=| Constants.symbolImageViewSize.height
            $0.width |=| Constants.symbolImageViewSize.width
        }
        
        titleLabel.layout {
            $0.top == symbolContainer.topAnchor
            $0.leading == symbolContainer.trailingAnchor + Constants.horizontalInset
            $0.trailing == container.trailingAnchor - Constants.horizontalInset
        }
        
        descriptionLabel.layout {
            $0.top == titleLabel.bottomAnchor + Constants.verticalInset
            $0.leading == symbolContainer.trailingAnchor + Constants.horizontalInset
            $0.trailing == favoriteButton.leadingAnchor - Constants.horizontalInset.halved
        }
        
        viewDetailsButton.layout {
            $0.top == descriptionLabel.bottomAnchor + Constants.verticalInset
            $0.leading == symbolContainer.trailingAnchor + Constants.horizontalInset.halved
            $0.bottom == symbolContainer.bottomAnchor
        }
        
        favoriteButton.layout {
            $0.centerY == symbolImageView.centerYAnchor
            $0.trailing == container.trailingAnchor
            $0.height |=| Constants.favoriteButtonSize.height
            $0.width |=| Constants.favoriteButtonSize.width
        }
    }
}

////MARK: - Model
//extension FavoriteCell {
//    struct UIModel {
//        var symbol: UIImage
//        var name: String
//        var description: String
//    }
//}
