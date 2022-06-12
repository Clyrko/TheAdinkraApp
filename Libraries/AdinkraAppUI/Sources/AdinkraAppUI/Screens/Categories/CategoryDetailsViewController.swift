import Foundation
import UIKit

private enum Constants {
    static let horizontalInset: CGFloat = 28
}

class CategoryDetailsViewController: UIViewController {
    private let navBar = PopOverNavigationBar()
    private var searchBar = StyleSearchBar()
    private var tableView: UITableView!
    
    var symbol: [CategorySymbolCell.UIModel] = [
        .init(name: "Gye Nyame", symbol: .named("symbol-gye-nyame")),
        .init(name: "ODO NNYEW FIE KWAN", symbol: .named("symbol-odo-nnyew-fie-kwan"))
        
        
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .styleWhite
        initializeView()
        layoutConstraint()
    }
    
    private func showSymbolDetailsScreen() {
        let controller = applicationDIProvider.makeSymbolDetailsController()
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
        self.showSymbolDetailsScreen()
    }
}

//MARK: - LAYOUT
extension CategoryDetailsViewController {
    private func initializeView() {
        navBar.onBackAction = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        
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
        
        tableView.layout {
            $0.top == searchBar.bottomAnchor + 20
            $0.leading == view.leadingAnchor
            $0.trailing == view.trailingAnchor
            $0.bottom == view.bottomAnchor
        }
    }
}
