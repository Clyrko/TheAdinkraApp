import Foundation
import Lottie
import UIKit

private enum Constants {
    static let iconImageViewSize = CGSize(width: 32, height: 32)
    static let closeButtonSize = CGSize(width: 30, height: 30)
    static let nextButtonSize = CGSize(width: 48, height: 48)
    static let horizontalInset: CGFloat = 24
    static let verticalInset: CGFloat = 24
    static let titleLabelTopInset: CGFloat = 8
    static let descriptionLabelTopInset: CGFloat = 16
    static let cornerRadius: CGFloat = 8
    static let doneButtonSize = CGSize(width: 72, height: 44)
}

class FTUXTourCardView: UIView {
    private var iconImageView: UIImageView!
    private var titleLabel: StyleLabel!
    private var closeButton: CloseButton!
    private var descriptionLabel: StyleLabel!
    private var pageCountLabel: StyleLabel!
    private var nextButton: AnimatedButton!
    private var doneButton: StyleButton!
    
    var onNextAction: Closure.Block?
    var onCloseAction: Closure.Block?
    var onDoneAction: Closure.Block?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeView()
        layoutConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func closeButtonPressed(sender: UIButton) {
        onCloseAction?()
    }
    
    func setup(with model: UiModel){
        iconImageView.image = model.icon
        titleLabel.text = model.title
        descriptionLabel.text = model.description
        pageCountLabel.text = "\(model.pageIndex)/\(model.totalPageCount)"
        doneButton.isHidden = model.totalPageCount != model.pageIndex
        nextButton.isHidden = model.totalPageCount == model.pageIndex
        nextButton.animationView.loopMode = .loop
        nextButton.animationView.play()
    }
    
    @objc private func onTapAction(sender: UIControl){
        onNextAction?()
    }
}

//MARK: - Layout
extension FTUXTourCardView {
    private func initializeView() {
        backgroundColor = .styleWhite
        dropCorner(Constants.cornerRadius)
    
        iconImageView = .init()
        iconImageView.contentMode = .scaleAspectFit
        
        titleLabel = .init(
            with: .header2,
            textColor: .styleBlack,
            textAlignment: .left
        )
        
        descriptionLabel = .init(
            with: .bodyBalsamiqBold,
            textColor: .styleBlack,
            textAlignment: .left
        )
        
        closeButton = CloseButton(frame: .zero, stroke: .styleBlack, fill: .white)
        closeButton.addTarget(self, action: #selector(closeButtonPressed(sender:)), for: .touchUpInside)
        
        nextButton = .init(animation: .named("Tours button")!)
        //nextButton.dropCorner(Constants.nextButtonSize.height.halved)
        nextButton.addTarget(self, action: #selector(onTapAction(sender:)), for: .touchUpInside)
        
        
        pageCountLabel = .init(
            with: .bodyMainRegular,
            textColor: .systemGray,
            textAlignment: .left
        )
        
        doneButton = .init(
            with: .primaryDefault,
            title: "ftux_card_done_button".localized
        )
        doneButton.isHidden = true
        doneButton.dropCorner(22)
        doneButton.onTapAction = { [weak self] in
            self?.onDoneAction?()
        }
        
        addSubview(iconImageView)
        addSubview(closeButton)
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(nextButton)
        addSubview(pageCountLabel)
        addSubview(doneButton)
    }
    
    private func layoutConstraint() {
        iconImageView.layout {
            $0.top == topAnchor + Constants.verticalInset
            $0.leading == leadingAnchor + Constants.horizontalInset
            $0.height |=| Constants.iconImageViewSize.height
            $0.width |=| Constants.iconImageViewSize.width
        }
        
        closeButton.layout {
            $0.top == topAnchor + Constants.verticalInset
            $0.trailing == trailingAnchor - Constants.horizontalInset
            $0.height |=| Constants.closeButtonSize.height
            $0.width |=| Constants.closeButtonSize.width
        }
        
        titleLabel.layout {
            $0.top == iconImageView.bottomAnchor + Constants.titleLabelTopInset
            $0.leading == leadingAnchor + Constants.horizontalInset
            $0.trailing == trailingAnchor - Constants.horizontalInset
        }
        
        descriptionLabel.layout {
            $0.top == titleLabel.bottomAnchor + Constants.descriptionLabelTopInset
            $0.leading == leadingAnchor + Constants.horizontalInset
            $0.trailing == trailingAnchor - Constants.horizontalInset
        }
        
        nextButton.layout {
            $0.top == descriptionLabel.bottomAnchor + Constants.verticalInset
            $0.trailing == trailingAnchor - Constants.horizontalInset
            $0.bottom == bottomAnchor - Constants.verticalInset
            $0.height |=| Constants.nextButtonSize.height
            $0.width |=| Constants.nextButtonSize.width
        }
        
        doneButton.layout {
            $0.trailing == trailingAnchor - Constants.horizontalInset
            $0.bottom == bottomAnchor - Constants.verticalInset
            $0.height |=| Constants.doneButtonSize.height
            $0.width |=| Constants.doneButtonSize.width
        }
        
        pageCountLabel.layout {
            $0.centerY == nextButton.centerYAnchor
            $0.leading == leadingAnchor + Constants.horizontalInset
        }
    }
}

extension FTUXTourCardView {
    struct UiModel {
        let icon: UIImage
        let title: String
        let description: String
        let pageIndex: Int
        let totalPageCount: Int
    }
}
