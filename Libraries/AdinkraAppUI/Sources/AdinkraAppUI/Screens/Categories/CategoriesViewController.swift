import Foundation
import UIKit

private enum Constants {
    static let itemSize = CGSize(width: (UIScreen.width - 60) / 2, height: 178)
    static let horizontalInset: CGFloat = 28
}

class CategoriesViewController: UIViewController {
    private let navBar = PopOverNavigationBar()
    private var searchBar = StyleSearchBar()
    private var collectionView: UICollectionView!
    
    var category: [CategoryCell.UIModel] = [
        .init(image: .named("symbol-akoma"), name: "Love"),
        .init(image: .named("symbol-sankofa"), name: "Wealth"),
        .init(image: .named("symbol-gye-nyame"), name: "Purity"),
        .init(image: .named("symbol-odo-nnyew-fie-kwan"), name: "Charity"),
        .init(image: .named("symbol-sankofa"), name: "Wisdom"),
        .init(image: .named("symbol-akofena"), name: "Knowledge")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .styleWhite
        initializeView()
        layoutConstraint()
    }
    
    private func showCategoryDetailsScreen() {
        let controller = applicationDIProvider.makeCategoryDetailsViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
}

//MARK: - COLLECTIONVIEW
extension CategoriesViewController: UICollectionViewDataSource,UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
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
        self.showCategoryDetailsScreen()
    }
}

//MARK: - LAYOUT
extension CategoriesViewController {
    private func initializeView() {
        navBar.onBackAction = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionViewFlowLayout.scrollDirection = .vertical
        collectionViewFlowLayout.minimumLineSpacing = 27
        collectionViewFlowLayout.minimumInteritemSpacing = 27
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.Identifier)
        
        view.addSubview(navBar)
        view.addSubview(searchBar)
        view.addSubview(collectionView)
    }
    
    private func layoutConstraint() {
        navBar.layout {
            $0.top == view.topAnchor
            $0.leading == view.leadingAnchor
            $0.trailing == view.trailingAnchor
        }
        
        searchBar.layout {
            $0.top == navBar.bottomAnchor + 36
            $0.leading == view.leadingAnchor + Constants.horizontalInset
            $0.trailing == view.trailingAnchor - Constants.horizontalInset
        }
        
        collectionView.layout {
            $0.top == searchBar.bottomAnchor + 20
            $0.leading == view.leadingAnchor + Constants.horizontalInset.halved
            $0.trailing == view.trailingAnchor - Constants.horizontalInset.halved
            $0.bottom == view.bottomAnchor
        }
    }
}
