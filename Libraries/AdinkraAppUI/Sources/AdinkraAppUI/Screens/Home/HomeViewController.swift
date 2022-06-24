import Foundation
import UIKit
import AVFoundation

private enum Constants {
    static let profileImageViewSize = CGSize(width: 50, height: 50)
    static let scanIconImageViewSize = CGSize(width: 24, height: 24)
    static let itemSize = CGSize(width: 152, height: 136)
    static let horizontalInset: CGFloat = 30
    static let verticalInset: CGFloat = 16
    static let viewInset: CGFloat = 40
    static let collectionViewHeight: CGFloat = 170
    static let collectionSpacing: CGFloat = 20
}

class HomeViewController: BaseViewController {
    private var pageHeader = TitleHeaderView()
    private var helloLabel: StyleLabel!
    private var scanIconImageView: UIImageView!
    private var searchBar = StyleSearchBar()
    private var viewAllSymbolsView = ViewAllHeaderView()
    private var viewAllCategoriesView = ViewAllHeaderView()
    private var collectionView: UICollectionView!
    private var symbolOfTheDayView = SymbolOfTheDayView()
    private var player: AVAudioPlayer!
    
//    var category: [CategoryCell.UIModel] = [
//        .init(image: .named("symbol-akoma"), name: "Love"),
//        .init(image: .named("symbol-bese-saka"), name: "Wealth"),
//        .init(image: .named("symbol-ananse-ntentan"), name: "Wisdom"),
//        .init(image: .named("symbol-mpatapo"), name: "Peace")
//    ]
    
    var category: [CategoriesPresentationModel] = [
        .init(id: 1, category: "Love", image: .named("symbol-akoma")),
        .init(id: 2, category: "Power", image: .named("symbol-adinkrahene")),
        .init(id: 3, category: "Strength", image: .named("symbol-aban")),
        .init(id: 4, category: "Wisdom", image: .named("symbol-akoma")),
        .init(id: 5, category: "Home", image: .named("symbol-akoma")),
        .init(id: 6, category: "Peace", image: .named("symbol-mpatapo")),
        .init(id: 7, category: "War", image: .named("symbol-akoben")),
        .init(id: 8, category: "Faith", image: .named("symbol-agyindawuru"))
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .styleWhite
        initializeView()
        layoutConstraint()
    }
    
    private func showAllSymbolScreen() {
        let controller = applicationDIProvider.makeViewAllSymbolsViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    private func showAllCategoriesScreen() {
        let controller = applicationDIProvider.makeCategoriesViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    private func showSymbolDetailsScreen() {
        let controller = applicationDIProvider.makeCategoriesViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    private func playSound() {
        guard let url = Bundle.module.url(forResource: "sankofa", withExtension: "mp3") else {
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

//MARK: - COLLECTIONVIEW
extension HomeViewController: UICollectionViewDataSource,UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        category.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.Identifier, for: indexPath) as? CategoryCell else { fatalError() }
        cell.setup(with: category[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return Constants.itemSize
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.showSymbolDetailsScreen()
    }
}

//MARK: - LAYOUT
extension HomeViewController {
    private func initializeView() {
        
        pageHeader.title = "Home"
        
        scanIconImageView = .init(image: .named("icon-24-scan"))
        scanIconImageView.contentMode = .scaleAspectFit
        
        helloLabel = .init(
            with: .header2,
            textColor: .mainOrange,
            textAlignment: .left,
            text: "Hello Jay!"
        )
        
        viewAllSymbolsView.title = "Symbols"
        viewAllSymbolsView.onViewAllAction = { [weak self] in
            self?.showAllSymbolScreen()
        }
        
        viewAllCategoriesView.title = "Categories"
        viewAllCategoriesView.onViewAllAction = { [weak self] in
            self?.showAllCategoriesScreen()
        }
        
        symbolOfTheDayView.onPlaySoundAction = { [weak self] in
            self?.playSound()
        }
        
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionViewFlowLayout.scrollDirection = .horizontal
        collectionViewFlowLayout.minimumInteritemSpacing = Constants.collectionSpacing
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.Identifier)
        collectionView.register(ViewAllHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ViewAllHeaderView.Identifier)
        
        view.addSubview(pageHeader)
        view.addSubview(helloLabel)
        view.addSubview(scanIconImageView)
        view.addSubview(searchBar)
        view.addSubview(viewAllSymbolsView)
        view.addSubview(viewAllCategoriesView)
        view.addSubview(collectionView)
        view.addSubview(symbolOfTheDayView)
    }
    
    private func layoutConstraint() {
        pageHeader.layout {
            $0.top == view.topAnchor
            $0.leading == view.leadingAnchor
            $0.trailing == view.trailingAnchor
        }
        
        helloLabel.layout {
            $0.top == pageHeader.bottomAnchor + Constants.viewInset
            $0.leading == view.leadingAnchor + Constants.horizontalInset
        }
        
        scanIconImageView.layout {
            $0.centerY == helloLabel.centerYAnchor
            $0.trailing == view.trailingAnchor - Constants.viewInset
            $0.height |=| Constants.scanIconImageViewSize.height
            $0.width |=| Constants.scanIconImageViewSize.width
        }
        
        searchBar.layout {
            $0.top == helloLabel.bottomAnchor + Constants.verticalInset
            $0.leading == view.leadingAnchor + Constants.horizontalInset
            $0.trailing == view.trailingAnchor - Constants.horizontalInset
        }
        
        viewAllSymbolsView.layout {
            $0.top == searchBar.bottomAnchor + Constants.verticalInset
            $0.leading == view.leadingAnchor
            $0.trailing == view.trailingAnchor
        }
        
        viewAllCategoriesView.layout {
            $0.top == viewAllSymbolsView.bottomAnchor + Constants.verticalInset
            $0.leading == view.leadingAnchor
            $0.trailing == view.trailingAnchor
        }
        
        collectionView.layout {
            $0.top == viewAllCategoriesView.bottomAnchor
            $0.leading == view.leadingAnchor + Constants.horizontalInset.halved
            $0.trailing == view.trailingAnchor - Constants.horizontalInset.halved
            $0.height |=| Constants.collectionViewHeight
        }
        
        symbolOfTheDayView.layout {
            $0.top == collectionView.bottomAnchor + Constants.viewInset
            $0.leading == view.leadingAnchor
            $0.trailing == view.trailingAnchor
        }
    }
}
