import Foundation
import UIKit

private enum Constants {
    static let symbolIconImageViewSize = CGSize(width: 160, height: 160)
    static let favoriteIconImageViewSize = CGSize(width: 30, height: 30)
    static let horizontalInset: CGFloat = 17
    static let verticalInset: CGFloat = 20
    static let cornerRadius: CGFloat = 8
    static let height: CGFloat = 300
}

class SymbolView: UIView {
    private var backgroundImageView: UIImageView!
    private var symbolImageView = UIImageView()
    private var symbolNameLabel: StyleLabel!
    private var favoriteIconImageView: UIImageView!
    
    var title: String? {
        didSet { symbolNameLabel.text = title }
    }
    
    var symbol: UIImage? {
        didSet { symbolImageView.image = symbol }
    }
    
    init(
        symbol: UIImage? = nil,
        title: String? = nil
    ) {
        self.symbol = symbol
        self.title = title
        super.init(frame: .zero)
        initializeView()
        layoutConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - LAYOUT
extension SymbolView {
    private func initializeView() {
        backgroundColor = .styleWhite
        dropCorner(Constants.cornerRadius)
        
        symbolImageView.image = symbol
        symbolImageView.contentMode = .scaleAspectFit
        
        backgroundImageView = .init(image: .named("symbol-background"))
        backgroundImageView.contentMode = .scaleToFill
        
        favoriteIconImageView = .init(image: .named("icon-30-favorite"))
        favoriteIconImageView.contentMode = .scaleAspectFit
        
        symbolNameLabel = .init(
           with: .header1,
           textColor: .styleBlack,
           textAlignment: .left,
           // FIXME: Put quotes around title
           text: title
        )
        
        addSubview(backgroundImageView)
        addSubview(symbolImageView)
        addSubview(symbolNameLabel)
        addSubview(favoriteIconImageView)
    }
    
    private func layoutConstraint() {
        layout {
            $0.height |=| Constants.height
        }
        backgroundImageView.pintToAllSidesOf(self)
        
        symbolImageView.layout {
            $0.centerX == centerXAnchor
            $0.centerY == centerYAnchor
            $0.height |=| Constants.symbolIconImageViewSize.height
            $0.width |=| Constants.symbolIconImageViewSize.width
        }
        
        symbolNameLabel.layout {
            $0.centerX == centerXAnchor
            $0.bottom == bottomAnchor - Constants.verticalInset
        }
        
        favoriteIconImageView.layout {
            $0.top == topAnchor + Constants.verticalInset.halved
            $0.trailing == trailingAnchor - Constants.horizontalInset
            $0.height |=| Constants.favoriteIconImageViewSize.height
            $0.width |=| Constants.favoriteIconImageViewSize.width
        }
    }
}