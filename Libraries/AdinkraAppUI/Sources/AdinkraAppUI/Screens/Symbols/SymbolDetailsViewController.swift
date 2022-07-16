import Foundation
import UIKit
import AVFoundation

private enum Constants {
    static let pronunciationIconImageViewSize = CGSize(width: 28, height: 28)
    static let horizontalInset: CGFloat = 28
    static let width = UIScreen.width
    static let scrollViewHeight: CGFloat = 800
}

class SymbolDetailsViewController: BaseViewController {
    private let navBar = PopOverNavigationBar()
    private var scrollView: UIScrollView!
    private var container = UIView()
    private var symbolView = SymbolView()
    private var symbolNameLabel: StyleLabel!
    private var symbolPronunciationButton: StyleButton!
    private var meaningLabel: StyleLabel!
    private var meaningDescriptionLabel: StyleLabel!
    private var detailsLabel: StyleLabel!
    private var detailsDescriptionLabel: StyleLabel!
    private var player: AVAudioPlayer!
    
    private var scrollViewHeightConstraint: NSLayoutConstraint!
    private var containerViewHeightConstraint: NSLayoutConstraint!
    
    var symbols: SymbolPresentationModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .styleWhite
        initializeView()
        layoutConstraint()
        populateSymbolDetails()
    }
    
    private func populateSymbolDetails() {
        symbolView.symbol = symbols.symbol
        symbolView.title = symbols.title
        symbolView.isFavorite = symbols.isFavorite
        meaningDescriptionLabel.text = symbols.meaning
        detailsDescriptionLabel.text = symbols.description
        if symbols.pronunciation == "" {
            symbolPronunciationButton.iconImageView.image = .init(systemName: "speaker.slash")
            symbolPronunciationButton.iconImageView.setImageMaskColor(.red)
            symbolPronunciationButton.isUserInteractionEnabled = false
        }
    }
    
    private func showProfileScreen() {
        let controller = applicationDIProvider.makeProfileViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    private func playSound() {
        guard let url = Bundle.module.url(forResource: symbols.pronunciation, withExtension: "mp3") else {
            print("File not found")
            return
        }
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player.play()
        } catch {
            print(error)
        }
    }
}

//MARK: - LAYOUT
extension SymbolDetailsViewController {
    private func initializeView() {
        navBar.onBackAction = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        navBar.onProfileAction = { [weak self] in
            self?.showProfileScreen()
        }
        navBar.title = "Symbol Details"
        
        scrollView = .init()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.isScrollEnabled = true
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.backgroundColor = .clear
        container.backgroundColor = .styleWhite
        
        symbolNameLabel = .init(
            with: .bodyBalsamiqBold,
            textColor: .mainOrange,
            textAlignment: .left
        )
        
        symbolPronunciationButton = .init(with: .indicator, title: nil)
        symbolPronunciationButton.iconImageView.image = .named("icon-28-sound")
        symbolPronunciationButton.canHighlight = false
        symbolPronunciationButton.backgroundColor = .clear
        symbolPronunciationButton.onTapAction = { [weak self] in
            self?.playSound()
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
        view.addSubview(scrollView)
        scrollView.addSubview(container)
        container.addSubview(symbolView)
        container.addSubview(symbolNameLabel)
        container.addSubview(symbolPronunciationButton)
        container.addSubview(meaningLabel)
        container.addSubview(meaningDescriptionLabel)
        container.addSubview(detailsLabel)
        container.addSubview(detailsDescriptionLabel)
    }
    
    private func layoutConstraint() {
        navBar.layout {
            $0.top == view.topAnchor
            $0.leading == view.leadingAnchor
            $0.trailing == view.trailingAnchor
        }
        
        scrollView.layout {
            $0.top == navBar.bottomAnchor + Constants.horizontalInset.halved
            $0.leading == view.leadingAnchor
            $0.trailing == view.trailingAnchor
            $0.bottom == view.bottomAnchor
            $0.width |=| Constants.width
        }
        scrollViewHeightConstraint = scrollView.heightAnchor.constraint(equalToConstant: Constants.scrollViewHeight)
        scrollViewHeightConstraint.isActive = true
        
        container.layout {
            $0.top == scrollView.topAnchor
            $0.leading == scrollView.leadingAnchor
            $0.trailing == scrollView.trailingAnchor
            $0.bottom == scrollView.bottomAnchor
            $0.width |=| Constants.width
        }
        containerViewHeightConstraint = container.heightAnchor.constraint(equalToConstant: Constants.scrollViewHeight)
        containerViewHeightConstraint.isActive = true
        
        symbolView.layout {
            $0.top == container.topAnchor
            $0.leading == container.leadingAnchor + 28
            $0.trailing == container.trailingAnchor - 28
        }
        
        symbolNameLabel.layout {
            $0.top == symbolView.bottomAnchor + 30
            $0.leading == container.leadingAnchor + 28
        }
        
        symbolPronunciationButton.layout {
            $0.centerY == symbolNameLabel.centerYAnchor
            $0.trailing == container.trailingAnchor - 28
            $0.height |=| Constants.pronunciationIconImageViewSize.height
            $0.width |=| Constants.pronunciationIconImageViewSize.width
        }
        
        meaningLabel.layout {
            $0.top == symbolNameLabel.bottomAnchor + 54
            $0.leading == container.leadingAnchor + Constants.horizontalInset
            $0.trailing == container.trailingAnchor - Constants.horizontalInset
        }
        
        meaningDescriptionLabel.layout {
            $0.top == meaningLabel.bottomAnchor + 3
            $0.leading == container.leadingAnchor + Constants.horizontalInset
            $0.trailing == container.trailingAnchor - Constants.horizontalInset
        }
        
        detailsLabel.layout {
            $0.top == meaningDescriptionLabel.bottomAnchor + 30
            $0.leading == container.leadingAnchor + Constants.horizontalInset
            $0.trailing == container.trailingAnchor - Constants.horizontalInset
        }
        
        detailsDescriptionLabel.layout {
            $0.top == detailsLabel.bottomAnchor + 3
            $0.leading == container.leadingAnchor + Constants.horizontalInset
            $0.trailing == container.trailingAnchor - Constants.horizontalInset
        }
    }
}
