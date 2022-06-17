import Foundation
import UIKit

private enum Constants {
    static let tableViewTopInset: CGFloat = 60
}

class FavoritesViewController: BaseViewController {
    private var pageHeader = TitleHeaderView()
    private var tableView: UITableView!
    
    private var symbol: [FavoriteCell.UIModel] = [
        .init(symbol: .named("symbol-eban"), name: "Eban", description: "TEST!"),
        .init(symbol: .named("symbol-ananse-ntentan"), name: "Ananse Ntentan", description: "TEST2"),
        .init(symbol: .named("symbol-fofo"), name: "Fofo", description: "TEST3"),
        .init(symbol: .named("symbol-mako"), name: "Mako", description: "TEST4"),
        .init(symbol: .named("symbol-nkyinkyim"), name: "Nkyinkyim", description: "TEST5")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .styleWhite
        initializeView()
        layoutConstraint()
    }
}

//MARK: - TABLEVIEW
extension FavoritesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        symbol.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteCell.Identifier, for: indexPath) as? FavoriteCell else { fatalError() }
        cell.setup(with: symbol[indexPath.row])
        return cell
    }

//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        self.showSymbolDetailsScreen()
//    }
}

//MARK: - LAYOUT
extension FavoritesViewController {
    private func initializeView() {
        pageHeader.title = "Favorites"
        
        tableView = .init(frame: .zero, style: .plain)
        tableView.backgroundColor = .styleWhite
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.allowsMultipleSelection = true
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(FavoriteCell.self, forCellReuseIdentifier: FavoriteCell.Identifier)
        
        view.addSubview(pageHeader)
        view.addSubview(tableView)
    }
    
    private func layoutConstraint() {
        pageHeader.layout {
            $0.top == view.topAnchor
            $0.leading == view.leadingAnchor
            $0.trailing == view.trailingAnchor
        }
        
        tableView.layout {
            $0.top == pageHeader.bottomAnchor + Constants.tableViewTopInset
            $0.leading == view.leadingAnchor
            $0.trailing == view.trailingAnchor
            $0.bottom == view.bottomAnchor
        }
    }
}
