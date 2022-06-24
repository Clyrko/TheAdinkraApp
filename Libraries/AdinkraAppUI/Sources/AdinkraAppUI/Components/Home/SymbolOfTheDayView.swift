import Foundation
import UIKit

private enum Constants {
    static let symbolIconImageViewSize = CGSize(width: 100, height: 100)
    static let favoriteIconImageViewSize = CGSize(width: 30, height: 30)
    static let soundIconImageViewSize = CGSize(width: 28, height: 28)
    static let horizontalInset: CGFloat = 25
    static let verticalInset: CGFloat = 20
    static let titleLabelHorizontalInset: CGFloat = 30
    static let labelTopInset: CGFloat = 35
    static let favoriteIconTrailingInset: CGFloat = 17
    static let symbolNameTopInset: CGFloat = 25
    static let symbolOfTheDayContainerHeight: CGFloat = 200
    static let cornerRadius: CGFloat = 8
}

class SymbolOfTheDayView: UIView {
    private var titleLabel: StyleLabel!
    private var symbolOfTheDayContainer = UIView()
    private var containerBackgroundImageView: UIImageView!
    private var symbolOfTheDayImageView: UIImageView!
    private var favoriteIconImageView: UIImageView!
    private var symbolNameLabel: StyleLabel!
    private var soundButton: StyleButton!
    private var meaningLabel: StyleLabel!
    private var meaningDescriptionLabel: StyleLabel!
    private var detailsLabel: StyleLabel!
    private var detailsDescriptionLabel: StyleLabel!
    
    var onPlaySoundAction: Closure.Block?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeView()
        layoutConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    func setup(with model: UiModel) {
//        descriptionLabel.font = StyleLabel.Style.captionBoldLarge.font
//        descriptionLabel.textColor = .styleBlack
//        descriptionLabel.text = model.description
//        iconImageView.alpha = .zero
//        progressView.isHidden = false
//        progressView.setup(with: model.completedCount, totalCount: model.totalCount)
//    }
}

//MARK: - LAYOUT
extension SymbolOfTheDayView {
    private func initializeView() {
        backgroundColor = .styleWhite
        
        symbolOfTheDayContainer.dropCorner(Constants.cornerRadius)
        
        containerBackgroundImageView = .init(image: .named("symbol-background"))
        containerBackgroundImageView.contentMode = .scaleAspectFit
        
        symbolOfTheDayImageView = .init(image: .named("symbol-sankofa"))
        symbolOfTheDayImageView.contentMode = .scaleAspectFit
        
        favoriteIconImageView = .init(image: .named("icon-30-favorite"))
        favoriteIconImageView.contentMode = .scaleAspectFit
        
        titleLabel = .init(
            with: .header2,
            textColor: .styleBlack,
            textAlignment: .left,
            text: "Symbol of the day"
        )
        
        symbolNameLabel = .init(
            with: .bodyMainRegular,
            textColor: .mainOrange,
            textAlignment: .left,
            text: "Sankofa"
        )
        
        soundButton = .init(with: .indicator, title: nil)
        soundButton.iconImageView.image = .named("icon-28-sound")
        soundButton.iconImageView.setImageMaskColor(.mainOrange)
        soundButton.canHighlight = false
        soundButton.backgroundColor = .styleWhite
        soundButton.onTapAction = { [weak self] in
            self?.onPlaySoundAction?()
        }
        
        meaningLabel = .init(
            with: .header2,
            textColor: .mainOrange,
            textAlignment: .left,
            text: "Meaning"
        )
        
        meaningDescriptionLabel = .init(
            with: .bodyMainRegular,
            textColor: .styleBlack,
            textAlignment: .left,
            text: "Return and get it."
        )
        
        detailsLabel = .init(
            with: .header2,
            textColor: .mainOrange,
            textAlignment: .left,
            text: "Details"
        )
        
        detailsDescriptionLabel = .init(
            with: .bodyMainRegular,
            textColor: .styleBlack,
            textAlignment: .left,
            text: "Sankofa is a word in the Twi language of Ghana meaning to retrieve and also refers to the Bono Adinkra symbol represented either with a stylized heart shape or by a bird with its head turned backwards while its feet face forward carrying a precious egg in its mouth."
        )
        
        addSubview(titleLabel)
        addSubview(symbolOfTheDayContainer)
        symbolOfTheDayContainer.addSubview(containerBackgroundImageView)
        symbolOfTheDayContainer.addSubview(symbolOfTheDayImageView)
        symbolOfTheDayContainer.addSubview(favoriteIconImageView)
        addSubview(symbolNameLabel)
        addSubview(soundButton)
        addSubview(meaningLabel)
        addSubview(meaningDescriptionLabel)
        addSubview(detailsLabel)
        addSubview(detailsDescriptionLabel)
    }
    
    private func layoutConstraint() {
        titleLabel.layout {
            $0.top == topAnchor
            $0.leading == leadingAnchor + Constants.titleLabelHorizontalInset
            $0.trailing == trailingAnchor - Constants.titleLabelHorizontalInset
        }
        
        symbolOfTheDayContainer.layout {
            $0.top == titleLabel.bottomAnchor + Constants.verticalInset
            $0.leading == leadingAnchor + Constants.horizontalInset
            $0.trailing == trailingAnchor - Constants.horizontalInset
            $0.height |=| Constants.symbolOfTheDayContainerHeight
        }
        
        containerBackgroundImageView.pintToAllSidesOf(symbolOfTheDayContainer)
        
        symbolOfTheDayImageView.layout {
            $0.centerX == symbolOfTheDayContainer.centerXAnchor
            $0.centerY == symbolOfTheDayContainer.centerYAnchor
            $0.height |=| Constants.symbolIconImageViewSize.height
            $0.width |=| Constants.symbolIconImageViewSize.width
        }
        
        favoriteIconImageView.layout {
            $0.top == symbolOfTheDayContainer.topAnchor + Constants.verticalInset.halved
            $0.trailing == symbolOfTheDayContainer.trailingAnchor - Constants.favoriteIconTrailingInset
            $0.height |=| Constants.favoriteIconImageViewSize.height
            $0.width |=| Constants.favoriteIconImageViewSize.width
        }
        
        symbolNameLabel.layout {
            $0.top == symbolOfTheDayContainer.bottomAnchor + Constants.symbolNameTopInset
            $0.leading == leadingAnchor + Constants.horizontalInset
            $0.trailing == soundButton.leadingAnchor - Constants.horizontalInset
        }
        
        soundButton.layout {
            $0.centerY == symbolNameLabel.centerYAnchor
            $0.trailing == trailingAnchor - Constants.horizontalInset
            $0.height |=| Constants.soundIconImageViewSize.height
            $0.width |=| Constants.soundIconImageViewSize.width
        }
        
        meaningLabel.layout {
            $0.top == symbolNameLabel.bottomAnchor + Constants.labelTopInset
            $0.leading == leadingAnchor + Constants.horizontalInset
            $0.trailing == trailingAnchor - Constants.horizontalInset
        }
        
        meaningDescriptionLabel.layout {
            $0.top == meaningLabel.bottomAnchor + Constants.verticalInset
            $0.leading == leadingAnchor + Constants.horizontalInset
            $0.trailing == trailingAnchor - Constants.horizontalInset
        }
        
        detailsLabel.layout {
            $0.top == meaningDescriptionLabel.bottomAnchor + Constants.labelTopInset
            $0.leading == leadingAnchor + Constants.horizontalInset
            $0.trailing == trailingAnchor - Constants.horizontalInset
        }
        
        detailsDescriptionLabel.layout {
            $0.top == detailsLabel.bottomAnchor + Constants.verticalInset
            $0.leading == leadingAnchor + Constants.horizontalInset
            $0.trailing == trailingAnchor - Constants.horizontalInset
            $0.bottom == bottomAnchor - Constants.verticalInset.halved
        }
    }
}

//MARK: - MODEL
//extension SymbolOfTheDayView {
//    struct UiModel {
//        let description: String
//        let completedCount: Double
//        let totalCount: Double
//    }
//}
