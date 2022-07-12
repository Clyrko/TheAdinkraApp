import Foundation
import UIKit

private enum Constants {
    static let viewSize = CGSize(width: 160, height: 160)
    static let symbolIconImageViewSize = CGSize(width: 80, height: 80)
    
    static let horizontalInset: CGFloat = 17
    static let verticalInset: CGFloat = 20
    static let cornerRadius: CGFloat = 8
    static let height: CGFloat = 300
}

class CategoryView: UIView {
    private var backgroundImageView: UIImageView!
    private var categoryImageView = UIImageView()
    
    
    var category: UIImage? {
        didSet { categoryImageView.image = category }
    }
    
    init(
        category: UIImage? = nil
    ) {
        self.category = category
        super.init(frame: .zero)
        initializeView()
        layoutConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - LAYOUT
extension CategoryView {
    private func initializeView() {
        backgroundColor = .styleWhite
        dropCorner(Constants.cornerRadius)
        
        categoryImageView.image = category
        categoryImageView.contentMode = .scaleAspectFit
        
        backgroundImageView = .init(image: .named("symbol-background"))
        backgroundImageView.contentMode = .scaleToFill
        
        addSubview(backgroundImageView)
        addSubview(categoryImageView)
    }
    
    private func layoutConstraint() {
        layout {
            $0.height |=| Constants.viewSize.height
            $0.width |=| Constants.viewSize.width
        }
        
        backgroundImageView.pintToAllSidesOf(self)
        
        categoryImageView.layout {
            $0.centerX == centerXAnchor
            $0.centerY == centerYAnchor
            $0.height |=| Constants.symbolIconImageViewSize.height
            $0.width |=| Constants.symbolIconImageViewSize.width
        }
    }
}
