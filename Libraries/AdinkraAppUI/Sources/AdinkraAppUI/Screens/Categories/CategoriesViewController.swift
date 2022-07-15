import Foundation
import UIKit

private enum Constants {
    static let itemSize = CGSize(width: (UIScreen.width - 60) / 2, height: 178)
    static let horizontalInset: CGFloat = 28
}

class CategoriesViewController: BaseViewController {
    private let navBar = PopOverNavigationBar()
    private var searchBar = StyleSearchBar()
    private var backgroundView = SearchNotFoundView()
    private var collectionView: UICollectionView!
    
    var category: [CategoriesPresentationModel] = [
        .init(id: 1, category: "Love", image: .named("symbol-akoma")),
        .init(id: 2, category: "Power", image: .named("symbol-adinkrahene")),
        .init(id: 3, category: "Strength", image: .named("symbol-aban")),
        .init(id: 4, category: "Wisdom", image: .named("symbol-akoma")),
        .init(id: 5, category: "Home", image: .named("symbol-akoma")),
        .init(id: 6, category: "Peace", image: .named("symbol-mpatapo")),
        .init(id: 7, category: "War", image: .named("symbol-akoben")),
        .init(id: 8, category: "Faith", image: .named("symbol-agyindawuru")),
        .init(id: 9, category: "Self", image: .named("symbol-ani-bere-a-enso-gya")),
        .init(id: 10, category: "Nature", image: .named("symbol-asase-ye-duru"))
    ]
    var dataSource: [CategoriesPresentationModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .styleWhite
        dataSource = category
        initializeView()
        layoutConstraint()
    }
    
    private func filterCategories(text: String){
        defer { collectionView.reloadData() }
        guard text.isNotEmpty else {
            dataSource = category
            return
        }
        dataSource = category.filter{ $0.category.localizedCaseInsensitiveContains(text)
        }
    }
    
    private func showProfileScreen() {
        let controller = applicationDIProvider.makeProfileViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
}

//MARK: - COLLECTIONVIEW
extension CategoriesViewController: UICollectionViewDataSource,UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if dataSource.isEmpty {
            backgroundView.frame = collectionView.frame
            collectionView.backgroundView = backgroundView
        }else{
            collectionView.backgroundView = nil
        }
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.Identifier, for: indexPath) as? CategoryCell else { fatalError() }
        cell.setup(with: dataSource[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return Constants.itemSize
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = CategoryDetailsViewController()
        controller.categories = dataSource[indexPath.row]
        navigationController?.pushViewController(controller, animated: true)
    }
}

//MARK: - LAYOUT
extension CategoriesViewController {
    private func initializeView() {
        navBar.onBackAction = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        navBar.onProfileAction = { [weak self] in
            self?.showProfileScreen()
        }
        navBar.title = "Categories"
        
        searchBar.onTextChanged = { [weak self] text in
            self?.filterCategories(text: text)
        }
        
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionViewFlowLayout.scrollDirection = .vertical
        collectionViewFlowLayout.minimumLineSpacing = 27
        collectionViewFlowLayout.minimumInteritemSpacing = 27
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.backgroundView = SearchNotFoundView()
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
