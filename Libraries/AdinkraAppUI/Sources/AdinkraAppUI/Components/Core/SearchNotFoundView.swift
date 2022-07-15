import Foundation
import UIKit

private enum Constants {
    static let searchImageViewSize = CGSize(width: 64, height: 64)
    static let borderWidth: CGFloat = 1
    static let verticalInset: CGFloat = 24
}

class SearchNotFoundView: UIView {
    private var searchImageView: UIImageView!
    private var titleLabel: StyleLabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeView()
        layoutConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

//MARK: - LAYOUT
extension SearchNotFoundView {
    private func initializeView() {
        backgroundColor = .styleWhite
        
        searchImageView = .init(image: .named("icon-64-search-minus"))
        searchImageView.contentMode = .scaleAspectFit
        
        titleLabel = .init(
            with: .bodyBalsamiqBold,
            textColor: .styleGray,
            textAlignment: .center,
            text: "Search has no results"
        )
        
        addSubview(searchImageView)
        addSubview(titleLabel)
    }
    
    private func layoutConstraint() {
        titleLabel.layout {
            $0.centerX == centerXAnchor
            $0.centerY == centerYAnchor
        }
        
        searchImageView.layout {
            $0.centerX == centerXAnchor
            $0.bottom == titleLabel.topAnchor - Constants.verticalInset
            $0.width |=| Constants.searchImageViewSize.width
            $0.height |=| Constants.searchImageViewSize.height
        }
    }
}
