import Foundation
import UIKit

private enum Constants {
    static let itemHeight: CGFloat = UIScreen.height * 0.32
    static let buttonHeight: CGFloat = 48
    static let cornerRadius: CGFloat = 12
}

class StoreItemViewController: BaseViewController {
    private let navBar = PopOverNavigationBar()
    private var itemImageView = UIImageView()
    private var itemTitleLabel: StyleLabel!
    private var itemPriceLabel: StyleLabel!
    private var itemDescriptionLabel: StyleLabel!
    
    private var buyNowButton: StyleButton!
    private var addToCartButton: StyleButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeView()
        layoutConstraint()
    }
    
    private func showProfileScreen() {
        let controller = applicationDIProvider.makeProfileViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    private func showAddToCartScreen() {
        let controller = applicationDIProvider.makeAddToCartViewController()
        controller.modalPresentationStyle = .overCurrentContext
        present(controller, animated: true)
    }
}

//MARK: - LAYOUT
extension StoreItemViewController {
    private func initializeView() {
        navBar.onBackAction = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        navBar.onProfileAction = { [weak self] in
            self?.showProfileScreen()
        }
        navBar.title = "Store"
        
        itemImageView.contentMode = .scaleAspectFit
        itemImageView.backgroundColor = .systemRed
        
        itemTitleLabel = .init(
            with: .header2,
            textColor: .styleBlack,
            textAlignment: .left,
            text: "Perserverance"
        )
        
        itemPriceLabel = .init(
            with: .header2,
            textColor: .styleBlack,
            textAlignment: .left,
            text: "$ 34.00"
        )
        
        itemDescriptionLabel = .init(
            with: .bodyMainRegular,
            textColor: .styleBlack,
            textAlignment: .left,
            text: "A Calvin Klein Bralet will perfectly complement your image. This is suitable for both trendy and casual. You just can’t go wrong with this."
        )
        
        buyNowButton = .init(with: .primaryDefault, title: "Buy Now")
        buyNowButton.titleColor = .styleWhite
        buyNowButton.dropCorner(Constants.cornerRadius)
        
        addToCartButton = .init(with: .secondaryDefault, title: "Add to cart")
        addToCartButton.backgroundColor = .white
        addToCartButton.titleColor = .mainOrange
        addToCartButton.borderlize(width: 1, color: .mainOrange)
        addToCartButton.dropCorner(Constants.cornerRadius)
        addToCartButton.onTapAction = { [weak self] in
            self?.showAddToCartScreen()
        }
        
        view.addSubview(navBar)
        view.addSubview(itemImageView)
        view.addSubview(itemTitleLabel)
        view.addSubview(itemPriceLabel)
        view.addSubview(itemDescriptionLabel)
        view.addSubview(addToCartButton)
        view.addSubview(buyNowButton)
    }
    
    private func layoutConstraint() {
        navBar.layout {
            $0.top == view.topAnchor
            $0.leading == view.leadingAnchor
            $0.trailing == view.trailingAnchor
        }
        
        itemImageView.layout {
            $0.top == navBar.bottomAnchor + 10
            $0.leading == view.leadingAnchor + 30
            $0.trailing == view.trailingAnchor - 30
            $0.height |=| Constants.itemHeight
        }
        
        itemTitleLabel.layout {
            $0.top == itemImageView.bottomAnchor + 50
            $0.leading == view.leadingAnchor + 50
        }
        
        itemPriceLabel.layout {
            $0.centerY == itemTitleLabel.centerYAnchor
            $0.trailing == view.trailingAnchor - 50
        }
        
        itemDescriptionLabel.layout {
            $0.top == itemPriceLabel.bottomAnchor + 16
            $0.leading == view.leadingAnchor + 50
            $0.trailing == view.trailingAnchor - 50
        }
        
        addToCartButton.layout {
            $0.leading == view.leadingAnchor + 40
            $0.trailing == view.trailingAnchor - 40
            $0.bottom == view.bottomAnchor - 40
            $0.height |=| Constants.buttonHeight
        }
        
        buyNowButton.layout {
            $0.leading == view.leadingAnchor + 40
            $0.trailing == view.trailingAnchor - 40
            $0.bottom == addToCartButton.topAnchor - 20
            $0.height |=| Constants.buttonHeight
        }
    }
}
