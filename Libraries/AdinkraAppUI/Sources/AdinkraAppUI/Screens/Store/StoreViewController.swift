import Foundation
import UIKit

private enum Constants {
    static let itemSize = CGSize(width: (UIScreen.width - 60) / 2, height: 250)
    static let cartButtonSize = CGSize(width: 65, height: 65)
    static let horizontalInset: CGFloat = 28
    static let cornerRadius: CGFloat = 8
    static let fontSize: CGFloat = 16
}

class StoreViewController: BaseViewController {
    private var pageHeader = TitleHeaderView()
    private var searchBar = StyleSearchBar()
    private var segmentedControl: UISegmentedControl!
    private var collectionView: UICollectionView!
    private var cartButton: StyleButton!
    
    private var shirts: [StoreCell.UIModel] = [
        .init(item: .named("symbol-akoben"), title: "Nice Shirt", price: "GHc45"),
        .init(item: .named("symbol-akoben"), title: "Nice Shirt", price: "GHc45"),
        .init(item: .named("symbol-akoben"), title: "Nice Shirt", price: "GHc45"),
        .init(item: .named("symbol-akoben"), title: "Nice Shirt", price: "GHc45"),
        .init(item: .named("symbol-akoben"), title: "Nice Shirt", price: "GHc45"),
        .init(item: .named("symbol-akoben"), title: "Nice Shirt", price: "GHc45"),
        .init(item: .named("symbol-akoben"), title: "Nice Shirt", price: "GHc45"),
        .init(item: .named("symbol-akoben"), title: "Nice Shirt", price: "GHc45")
    ]
    
    private var accessories: [StoreCell.UIModel] = [
        .init(item: .named("symbol-ani-bere-a-enso-gya"), title: "Nice Accessory", price: "GHc45"),
        .init(item: .named("symbol-ani-bere-a-enso-gya"), title: "Nice Accessory", price: "GHc45"),
        .init(item: .named("symbol-ani-bere-a-enso-gya"), title: "Nice Accessory", price: "GHc45"),
        .init(item: .named("symbol-ani-bere-a-enso-gya"), title: "Nice Accessory", price: "GHc45"),
        .init(item: .named("symbol-ani-bere-a-enso-gya"), title: "Nice Accessory", price: "GHc45"),
        .init(item: .named("symbol-ani-bere-a-enso-gya"), title: "Nice Accessory", price: "GHc45"),
        .init(item: .named("symbol-ani-bere-a-enso-gya"), title: "Nice Accessory", price: "GHc45"),
        .init(item: .named("symbol-ani-bere-a-enso-gya"), title: "Nice Accessory", price: "GHc45")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .styleWhite
        initializeView()
        layoutConstraint()
    }
    
    private func showProfileScreen() {
        let controller = applicationDIProvider.makeProfileViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc private func segmentedControlPressed(_ segmentedControl: UISegmentedControl) {
        collectionView.reloadData()
    }
}
//MARK: - COLLECTIONVIEW
extension StoreViewController: UICollectionViewDataSource,UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            return shirts.count
        case 1:
            return accessories.count
        default:
            break
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StoreCell.Identifier, for: indexPath) as? StoreCell else { fatalError() }
            cell.setup(with: shirts[indexPath.row])
            return cell
        case 1:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StoreCell.Identifier, for: indexPath) as? StoreCell else { fatalError() }
            cell.setup(with: accessories[indexPath.row])
            return cell
        default:
            break
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return Constants.itemSize
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = applicationDIProvider.makeStoreItemViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
}

//MARK: - LAYOUT
extension StoreViewController {
    private func initializeView() {
        pageHeader.title = "Store"
        pageHeader.onProfileAction  = { [weak self] in
            self?.showProfileScreen()
        }
        
        segmentedControl = .init(items: ["Shirts", "Accessories"])
        segmentedControl.dropCorner(Constants.cornerRadius)
        segmentedControl.backgroundColor = .styleWhite
        segmentedControl.setTitleTextAttributes([
            .foregroundColor : UIColor.styleBlack,
            .font : UIFont.montserrat(weight: .bold, size: Constants.fontSize)
        ], for: .normal)
        segmentedControl.setTitleTextAttributes([
            .foregroundColor : UIColor.styleWhite,
            .font : UIFont.montserrat(weight: .bold, size: Constants.fontSize)
        ], for: .selected)
        segmentedControl.selectedSegmentTintColor = .mainOrange
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(segmentedControlPressed(_:)), for: .valueChanged)
        
        cartButton = .init(with: .indicator, title: nil)
        cartButton.iconImageView.image = .named("icon-30-cart")
        cartButton.backgroundColor = .mainOrange
        cartButton.dropCorner(Constants.cartButtonSize.height.halved)
        
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionViewFlowLayout.scrollDirection = .vertical
        collectionViewFlowLayout.minimumLineSpacing = 8
        collectionViewFlowLayout.minimumInteritemSpacing = 8
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(StoreCell.self, forCellWithReuseIdentifier: StoreCell.Identifier)
        
        view.addSubview(pageHeader)
        view.addSubview(searchBar)
        view.addSubview(segmentedControl)
        view.addSubview(collectionView)
        view.addSubview(cartButton)
    }
    
    private func layoutConstraint() {
        pageHeader.layout {
            $0.top == view.topAnchor
            $0.leading == view.leadingAnchor
            $0.trailing == view.trailingAnchor
        }
        
        searchBar.layout {
            $0.top == pageHeader.bottomAnchor + 36
            $0.leading == view.leadingAnchor + Constants.horizontalInset
            $0.trailing == view.trailingAnchor - Constants.horizontalInset
        }
        
        segmentedControl.layout {
            $0.top == searchBar.bottomAnchor + 20
            $0.leading == view.leadingAnchor + Constants.horizontalInset
            $0.trailing == view.trailingAnchor - Constants.horizontalInset
            $0.height |=| 50
        }
        
        collectionView.layout {
            $0.top == segmentedControl.bottomAnchor + 20
            $0.leading == view.leadingAnchor + Constants.horizontalInset.halved
            $0.trailing == view.trailingAnchor - Constants.horizontalInset.halved
            $0.bottom == view.bottomAnchor
        }
        
        cartButton.layout {
            $0.trailing == view.trailingAnchor - 30
            $0.bottom == view.bottomAnchor - 60
            $0.height |=| Constants.cartButtonSize.height
            $0.width |=| Constants.cartButtonSize.width
        }
    }
}

