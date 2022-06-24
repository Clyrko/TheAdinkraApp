import Foundation
import UIKit

private enum Constants {
    static let pronunciationIconImageViewSize = CGSize(width: 28, height: 28)
    static let horizontalInset: CGFloat = 28
}

class SymbolDetailsViewController: BaseViewController {
    private let navBar = PopOverNavigationBar()
    private var symbolView = SymbolView()
    private var symbolNameLabel: StyleLabel!
    private var symbolPronunciationButton: StyleButton!
    private var meaningLabel: StyleLabel!
    private var meaningDescriptionLabel: StyleLabel!
    private var detailsLabel: StyleLabel!
    private var detailsDescriptionLabel: StyleLabel!
    
    var symbol: SymbolPresentationModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .styleWhite
        initializeView()
        layoutConstraint()
        populateSymbolDetails()
    }
    
    private func populateSymbolDetails() {
        symbolView.symbol = symbol.symbol
        symbolView.title = symbol.title
        meaningDescriptionLabel.text = symbol.meaning
        detailsDescriptionLabel.text = symbol.description
    }
}

//MARK: - LAYOUT
extension SymbolDetailsViewController {
    private func initializeView() {
        navBar.onBackAction = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        
        symbolNameLabel = .init(
            with: .bodyBalsamiqBold,
            textColor: .mainOrange,
            textAlignment: .left
        )
        
        symbolPronunciationButton = .init(with: .indicator, title: nil)
        symbolPronunciationButton.iconImageView.image = .named("icon-28-sound")
        symbolPronunciationButton.backgroundColor = .clear
//        symbolPronunciationButton.onTapAction = { [weak self] in
//        }
        
        meaningLabel = .init(
            with: .header2,
            textColor: .mainOrange,
            textAlignment: .left,
            text: "Meaning"
        )
        
        meaningDescriptionLabel = .init(
            with: .bodyMainRegular,
            textColor: .styleBlack,
            textAlignment: .left
            //FIXME: add quotes or maybe another section
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
            textAlignment: .left
        )
        
        view.addSubview(navBar)
        view.addSubview(symbolView)
        view.addSubview(symbolNameLabel)
        view.addSubview(symbolPronunciationButton)
        view.addSubview(meaningLabel)
        view.addSubview(meaningDescriptionLabel)
        view.addSubview(detailsLabel)
        view.addSubview(detailsDescriptionLabel)
    }
    
    private func layoutConstraint() {
        navBar.layout {
            $0.top == view.topAnchor
            $0.leading == view.leadingAnchor
            $0.trailing == view.trailingAnchor
        }
        
        symbolView.layout {
            $0.top == navBar.bottomAnchor + 28
            $0.leading == view.leadingAnchor + 28
            $0.trailing == view.trailingAnchor - 28
        }
        
        symbolNameLabel.layout {
            $0.top == symbolView.bottomAnchor + 30
            $0.leading == view.leadingAnchor + 28
        }
        
        symbolPronunciationButton.layout {
            $0.centerY == symbolNameLabel.centerYAnchor
            $0.trailing == view.trailingAnchor - 28
            $0.height |=| Constants.pronunciationIconImageViewSize.height
            $0.width |=| Constants.pronunciationIconImageViewSize.width
        }
        
        meaningLabel.layout {
            $0.top == symbolNameLabel.bottomAnchor + 54
            $0.leading == view.leadingAnchor + Constants.horizontalInset
            $0.trailing == view.trailingAnchor - Constants.horizontalInset
        }
        
        meaningDescriptionLabel.layout {
            $0.top == meaningLabel.bottomAnchor + 3
            $0.leading == view.leadingAnchor + Constants.horizontalInset
            $0.trailing == view.trailingAnchor - Constants.horizontalInset
        }
        
        detailsLabel.layout {
            $0.top == meaningDescriptionLabel.bottomAnchor + 30
            $0.leading == view.leadingAnchor + Constants.horizontalInset
            $0.trailing == view.trailingAnchor - Constants.horizontalInset
        }
        
        detailsDescriptionLabel.layout {
            $0.top == detailsLabel.bottomAnchor + 3
            $0.leading == view.leadingAnchor + Constants.horizontalInset
            $0.trailing == view.trailingAnchor - Constants.horizontalInset
        }
    }
}
