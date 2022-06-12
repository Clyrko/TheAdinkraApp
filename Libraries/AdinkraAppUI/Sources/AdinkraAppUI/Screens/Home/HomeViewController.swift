import Foundation
import UIKit

private enum Constants {
    static let profileImageViewSize = CGSize(width: 50, height: 50)
    static let scanIconImageViewSize = CGSize(width: 24, height: 24)
    static let itemSize = CGSize(width: 152, height: 136)
    static let horizontalInset: CGFloat = 30
}

class HomeViewController: BaseViewController {
    private var pageHeader = TitleHeaderView()
    private var helloLabel: StyleLabel!
    private var scanIconImageView: UIImageView!
    private var searchBar = StyleSearchBar()
    private var viewAllSymbolsView = ViewAllHeaderView()
    private var collectionView: UICollectionView!
    private var symbolOfTheDayView = SymbolOfTheDayView()
    
    var category: [CategoryCell.UIModel] = [
        .init(image: .named("symbol-abe-dua"), name: "Love"),
        .init(image: .named("symbol-sankofa"), name: "Wealth"),
        .init(image: .named("symbol-sankofa"), name: "Purity"),
        .init(image: .named("symbol-sankofa"), name: "Charity")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .styleWhite
        initializeView()
        layoutConstraint()
    }
    
    private func showSymbolDetailsScreen() {
        let controller = applicationDIProvider.makeCategoriesViewController()
        navigationController?.pushViewController(controller, animated: true)
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
    
    //    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    //        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ViewAllHeaderView.Identifier, for: indexPath) as? ViewAllHeaderView else { fatalError() }
    //        header.title = "Categories"
    //        return header
    //    }
}

//MARK: - LAYOUT
extension HomeViewController {
    private func initializeView() {
        
        pageHeader.title = "Home"
        //        pageHeader.onProfileAction = { [weak self] in
        //        }
        
        scanIconImageView = .init(image: .named("icon-24-scan"))
        scanIconImageView.contentMode = .scaleAspectFit
        
        helloLabel = .init(
            with: .header2,
            textColor: .mainOrange,
            textAlignment: .left,
            text: "Hello Jay!"
        )
        
        viewAllSymbolsView.title = "Symbols"
//        viewAllSymbolsView.onViewAllAction = { [weak self] in
//        }
        
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionViewFlowLayout.scrollDirection = .horizontal
        collectionViewFlowLayout.minimumInteritemSpacing = 20
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
            $0.top == pageHeader.bottomAnchor + 40
            $0.leading == view.leadingAnchor + Constants.horizontalInset
        }
        
        scanIconImageView.layout {
            $0.centerY == helloLabel.centerYAnchor
            $0.trailing == view.trailingAnchor - 40
            $0.height |=| Constants.scanIconImageViewSize.height
            $0.width |=| Constants.scanIconImageViewSize.width
        }
        
        searchBar.layout {
            $0.top == helloLabel.bottomAnchor + 16
            $0.leading == view.leadingAnchor + Constants.horizontalInset
            $0.trailing == view.trailingAnchor - Constants.horizontalInset
        }
        
        viewAllSymbolsView.layout {
            $0.top == searchBar.bottomAnchor + 16
            $0.leading == view.leadingAnchor
            $0.trailing == view.trailingAnchor
        }
        
        collectionView.layout {
            $0.top == viewAllSymbolsView.bottomAnchor + 20
            $0.leading == view.leadingAnchor + Constants.horizontalInset.halved
            $0.trailing == view.trailingAnchor - Constants.horizontalInset.halved
            $0.height |=| 170
        }
        
        symbolOfTheDayView.layout {
            $0.top == collectionView.bottomAnchor + 50
            $0.leading == view.leadingAnchor
            $0.trailing == view.trailingAnchor
        }
    }
}
