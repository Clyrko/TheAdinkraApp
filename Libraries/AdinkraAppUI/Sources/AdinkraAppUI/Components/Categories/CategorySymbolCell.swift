import Foundation
import UIKit

private enum Constants {
    static let symbolImageViewSize = CGSize(width: 100, height: 100)
    static let favoriteButtonSize = CGSize(width: 30, height: 30)
    static let nextButtonSize = CGSize(width: 24, height: 24)
    static let height: CGFloat = 231
    static let insets = UIEdgeInsets(top: 12, left: 28, bottom: 12, right: 28)
}

class CategorySymbolCell: UITableViewCell {
    private var container = UIView()
    private var backgroundImageView: UIImageView!
    private var titleLabel: StyleLabel!
    private var symbolImageView = UIImageView()
    private var favoriteButton = UIButton()
    private var nextButton: UIImageView!
    
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
    
    func setup(with category: SymbolPresentationModel) {
        titleLabel.text = category.title
        symbolImageView.image = category.symbol
    }
}

//MARK: - LAYOUT
extension CategorySymbolCell {
    private func initializeView() {
        selectionStyle = .none
        container.isUserInteractionEnabled = false
        
        backgroundImageView = .init(image: .named("symbol-background"))
        backgroundImageView.contentMode = .scaleToFill
        
        favoriteButton.setImage(.init(systemName: "suit.heart"), for: .normal)
        favoriteButton.setImage(.init(systemName: "suit.heart.fill"), for: .selected)
        favoriteButton.tintColor = .mainOrange
        favoriteButton.addTarget(self, action: #selector(onTap), for: .touchUpInside)
        favoriteButton.isHidden = true
        
        nextButton = .init(image: .named("icon-24-arrow-right"))
        nextButton.setImageMaskColor(.styleBlack)
        nextButton.contentMode = .scaleAspectFit
        
        symbolImageView.contentMode = .scaleAspectFit
        
        titleLabel = .init(
            with: .header2,
            textColor: .styleBlack,
            textAlignment: .left
        )
        
        contentView.addSubview(container)
        container.addSubview(backgroundImageView)
        container.addSubview(titleLabel)
        container.addSubview(symbolImageView)
        container.addSubview(favoriteButton)
        container.addSubview(nextButton)
    }
    
    private func layoutConstraint() {
        container.pintToAllSidesOf(contentView, insets: Constants.insets)
        container.layout {
            $0.height |=| Constants.height
        }
        
        backgroundImageView.pintToAllSidesOf(container)
        
        titleLabel.layout {
            $0.top == container.topAnchor + 20
            $0.leading == container.leadingAnchor + 28
        }
        
        symbolImageView.layout {
            $0.centerX == container.centerXAnchor
            $0.centerY == container.centerYAnchor
            $0.height |=| Constants.symbolImageViewSize.height
            $0.width |=| Constants.symbolImageViewSize.width
        }
        
        favoriteButton.layout {
            $0.top == container.topAnchor + 11
            $0.trailing == container.trailingAnchor - 11
            $0.height |=| Constants.favoriteButtonSize.height
            $0.width |=| Constants.favoriteButtonSize.width
        }
        
        nextButton.layout {
            $0.trailing == container.trailingAnchor - 30
            $0.bottom == container.bottomAnchor - 36
            $0.height |=| Constants.nextButtonSize.height
            $0.width |=| Constants.nextButtonSize.width
        }
    }
}

