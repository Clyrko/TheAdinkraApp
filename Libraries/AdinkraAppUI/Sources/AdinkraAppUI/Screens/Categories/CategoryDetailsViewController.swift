import Foundation
import UIKit

private enum Constants {
    static let scanButtonSize = CGSize(width: 24, height: 24)
    static let horizontalInset: CGFloat = 28
}

class CategoryDetailsViewController: BaseViewController {
    private let navBar = PopOverNavigationBar()
    private var searchBar = StyleSearchBar()
    private var categoriesTitleLabel: StyleLabel!
    private var categoryLabel: StyleLabel!
    private var scanButton: StyleButton!
    private var categoryImageView = CategoryView()
    private var horizontalLine = UIView()
    private var tableView: UITableView!
    
    var categories: CategoriesPresentationModel!
    
//    var symbol: [CategorySymbolCell.UIModel] = [
//        .init(name: "Gye Nyame", symbol: .named("symbol-gye-nyame")),
//        .init(name: "ODO NNYEW FIE KWAN", symbol: .named("symbol-odo-nnyew-fie-kwan"))
//    ]
    
    var symbol: [SymbolPresentationModel] = [
        .init(id: 1, symbol: .named("symbol-aban"), title: "Aban", meaning: "A symbol of strength, seat of power, authority, and magnificence.", description: "Aban is the Akan word for “fortress” or “castle.”", pronunciation: "LOL", categories: ["Strength", "Power"], isFavorite: false),
        .init(id: 2, symbol: .named("symbol-abe-dua"), title: "Abe Dua", meaning: "Abe Dua means palm tree.", description: "The palm tree is a symbol resourcefulnees because many diverse products emanate from that single tree: wine, oil, brooms, roofing material, etc.", pronunciation: "LOL", categories: ["Wealth", "Resourcefulness"], isFavorite: false),
        .init(id: 3, symbol: .named("symbol-adinkrahene"), title: "Adinkrahene", meaning: "Adinkrahene means King of the Adinkra symbols. It is a symbol for authority, leadership, and charisma.", description: "The etymology of Adinkrahene is Adinkra + ɔhene, literally “Adinkra king” or “king of the Adinkras.” This symbol is reportedly the inspiration of the design of the other symbols. The elegant figure with three concentric circles is easy to draw and its abstract form connotes the importance of ideas and concepts, which are the essence of Adinkra–they are visual representations of important concepts in Akan philosophy.", pronunciation: "LOL", categories: ["Authority", "Leadership"], isFavorite: false)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .styleWhite
        initializeView()
        layoutConstraint()
        populate()
    }
    
    private func populate() {
        categoryLabel.text = categories.category
        categoryImageView.category = categories.image
    }
    
    private func showScanScreen() {
        let controller = applicationDIProvider.makeScanViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
}

//MARK: - TABLEVIEW
extension CategoryDetailsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        symbol.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CategorySymbolCell.Identifier, for: indexPath) as? CategorySymbolCell else { fatalError() }
        cell.setup(with: symbol[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = SymbolDetailsViewController()
        controller.symbols = symbol[indexPath.row]
        navigationController?.pushViewController(controller, animated: true)
    }
}

//MARK: - LAYOUT
extension CategoryDetailsViewController {
    private func initializeView() {
        navBar.onBackAction = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        
        categoriesTitleLabel = .init(
            with: .header2,
            textColor: .styleBlack,
            textAlignment: .left,
            text: "Category"
        )
        
        categoryLabel = .init(
            with: .header2,
            textColor: .mainOrange,
            textAlignment: .left
        )
        
        scanButton = .init(with: .indicator, title: nil)
        scanButton.iconImageView.image = .named("icon-24-scan")
        scanButton.backgroundColor = .styleWhite
        scanButton.canHighlight = false
        scanButton.onTapAction = { [weak self] in
            self?.showScanScreen()
        }
        
        horizontalLine.backgroundColor = .systemGray
        
        tableView = .init(frame: .zero, style: .grouped)
        tableView.backgroundColor = .styleWhite
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.allowsMultipleSelection = true
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CategorySymbolCell.self, forCellReuseIdentifier: CategorySymbolCell.Identifier)
        
        view.addSubview(navBar)
        view.addSubview(searchBar)
        view.addSubview(categoriesTitleLabel)
        view.addSubview(categoryLabel)
        view.addSubview(scanButton)
        view.addSubview(categoryImageView)
        view.addSubview(horizontalLine)
        view.addSubview(tableView)
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
        
        categoriesTitleLabel.layout {
            $0.top == searchBar.bottomAnchor + 20
            $0.leading == view.leadingAnchor + Constants.horizontalInset
        }
        
        categoryLabel.layout {
            $0.centerY == categoriesTitleLabel.centerYAnchor
            $0.leading == categoriesTitleLabel.trailingAnchor + 4
        }
        
        scanButton.layout {
            $0.centerY == categoriesTitleLabel.centerYAnchor
            $0.trailing == view.trailingAnchor - 36
            $0.height |=| Constants.scanButtonSize.height
            $0.width |=| Constants.scanButtonSize.width
        }
        
        categoryImageView.layout {
            $0.top == categoriesTitleLabel.bottomAnchor + 20
            $0.leading == view.leadingAnchor + 32
        }
        
        horizontalLine.layout {
            $0.top == categoryImageView.bottomAnchor + 10
            $0.leading == view.leadingAnchor + 30
            $0.trailing == view.trailingAnchor - 30
            $0.height |=| 1
        }
        
        tableView.layout {
            $0.top == horizontalLine.bottomAnchor
            $0.leading == view.leadingAnchor
            $0.trailing == view.trailingAnchor
            $0.bottom == view.bottomAnchor
        }
    }
}
