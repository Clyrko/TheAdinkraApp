import Foundation
import UIKit

private enum Constants {
    static let iconImageViewSize = CGSize(width: 50, height: 50)
    static let closeButtonSize = CGSize(width: 24, height: 24)
    static let cornerRadius: CGFloat = 8
    static let overlayAlpha: CGFloat = 0.70
}

class AddToCartViewController: BaseViewController {
    private var overlay = UIView()
    private var cardView = UIView()
    private var closeButton: CloseButton!
    private var iconImageView: UIImageView!
    private var titleLabel: StyleLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeView()
        layoutConstraint()
    }
    
    @objc private func closeButtonPressed(sender: UIButton) {
        dismiss(animated: true)
    }
}

//MARK: - LAYOUT
extension AddToCartViewController {
    private func initializeView() {
        overlay.backgroundColor = .styleBlack.withAlphaComponent(Constants.overlayAlpha)
        
        cardView.backgroundColor = .styleWhite
        cardView.dropCorner(Constants.cornerRadius)
        
        closeButton = CloseButton(frame: .zero, stroke: .styleBlack, fill: .white)
        closeButton.addTarget(self, action: #selector(closeButtonPressed(sender:)), for: .touchUpInside)
        
        titleLabel = .init(
            with: .bodyBalsamiqBold,
            textColor: .styleBlack,
            textAlignment: .center,
            text: "Item added to cart successfully!"
        )
        
        iconImageView = .init(image: .named("icon-30-cart"))
        iconImageView.setImageMaskColor(.mainOrange)
        
        view.addSubview(overlay)
        view.addSubview(cardView)
        cardView.addSubview(closeButton)
        cardView.addSubview(titleLabel)
        cardView.addSubview(iconImageView)
    }
    
    private func layoutConstraint() {
        overlay.pintToAllSidesOf(view)
        
        cardView.layout {
            $0.centerY == view.centerYAnchor
            $0.centerX == view.centerXAnchor
            $0.leading == view.leadingAnchor + 40
            $0.trailing == view.trailingAnchor - 40
        }
        
        closeButton.layout {
            $0.top == cardView.topAnchor + 12
            $0.trailing == cardView.trailingAnchor - 22
            $0.height |=| Constants.closeButtonSize.height
            $0.width |=| Constants.closeButtonSize.width
        }
        
        titleLabel.layout {
            $0.top == closeButton.bottomAnchor + 8
            $0.leading == cardView.leadingAnchor + 70
            $0.trailing == cardView.trailingAnchor - 70
        }
        
        iconImageView.layout {
            $0.centerX == cardView.centerXAnchor
            $0.top == titleLabel.bottomAnchor + 8
            $0.bottom == cardView.bottomAnchor - 32
            $0.height |=| Constants.iconImageViewSize.height
            $0.width |=| Constants.iconImageViewSize.width
        }
    }
}
