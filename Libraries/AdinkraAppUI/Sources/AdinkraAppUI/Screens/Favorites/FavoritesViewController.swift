import Foundation
import UIKit

private enum Constants {
}

class FavoritesViewController: BaseViewController {
    private var pageHeader = TitleHeaderView()
    private var tableView: UITableView!
    
//    private var symbol: [FavoriteCell.UIModel] = [
//        .init(symbol: .named("symbol-eban"), name: "Eban", description: "Eban means “fence.” It is a symbol of safety, security, and love."),
//        .init(symbol: .named("symbol-ananse-ntentan"), name: "Ananse Ntentan", description: "Ananse Ntentan means “spider’s web.” The spider in Akan folklore–Ananse–is crafty and creative, and always outwitting his contemporaries by fair or foul means. Ananse Ntentan is a symbol of wisdom, craftiness, creativity, and the complexities of life."),
//        .init(symbol: .named("symbol-fofo"), name: "Fofo", description: "Fofo is the name of a flowering plant (bidens pilosa). It is a symbol of warning against jealousy and covetousness."),
//        .init(symbol: .named("symbol-mako"), name: "Mako", description: "Mako means “peppers.” It is a symbol of inequality and uneven development."),
//        .init(symbol: .named("symbol-nkyinkyim"), name: "Nkyinkyim", description: "Nkyinkyim means “twisting.” It is a symbol representing the tortuous nature of life’s journey.")
//    ]
    
    private var symbol: [SymbolPresentationModel] = [
        .init(id: 23, symbol: .named("symbol-eban"), title: "Eban", meaning: "Eban means “fence.” It is a symbol of safety, security, and love.", description: "The home of the Akan is a special place. A home which has a fence around it is considered to be an ideal residence", pronunciation: "eban", categories: ["Love", "Home"], isFavorite: true),
        .init(id: 11, symbol: .named("symbol-ananse-ntentan"), title: "Ananse Ntentan", meaning: "Ananse Ntentan means “spider’s web.” The spider in Akan folklore–Ananse–is crafty and creative, and always outwitting his contemporaries by fair or foul means. Ananse Ntentan is a symbol of wisdom, craftiness, creativity, and the complexities of life.", description: "Ananse, the famous spider in Akan folktales is known for his cunning. However, in general, the spider is also respected for his creativity in weaving a web that is able to trap prey. The spider’s web is known for its strength. Indeed, a string of the web is known to be stronger and more versatile than steel of the same thickness.When Ananse features in folk tales, he usually comes along with Ntikuma, his son, Okonore Yaa, and some other family members. Known for the cheat he is, his associates are always wary of his antics lest they fall prey to his wit.", pronunciation: "ananse-ntentan", categories: ["Wisdom"], isFavorite: true),
        .init(id: 28, symbol: .named("symbol-fofo"), title: "Fofo", meaning: "Fofo is the name of a flowering plant (bidens pilosa). It is a symbol of warning against jealousy and covetousness.", description: "This plant has yellow flowers which turn into black spiky-like seeds when its petals drop.", pronunciation: "", categories: ["Nature"], isFavorite: true),
        .init(id: 36, symbol: .named("symbol-mako"), title: "Mako", meaning: "Mako means “peppers.” It is a symbol of inequality and uneven development.", description: "Mako is a shortened form of the Akan proverb “Mako nyinaa mpatu mmere,” literally “All peppers (presumably on the same branch) do not ripen simultaneously.”This proverb admonishes the greater ones to help the less fortunate with the implicit understanding that fortunes could reverse so that they would also need someone’s help. As the Akans say, “Mmerɛ dane,” literally, “Time changes” so any advantage one may have now may not persist forever.“Mako nyinaa mpatu mmere” could also be an exhortation to those behind to strive for advancement and not resign to fate. That someone has attained greatness shows that it is attainable. Yes, some may shoot ahead first but eventually others can catch up—eventually all the peppers will ripen.", pronunciation: "mako", categories: ["Self"], isFavorite: true),
        .init(id: 44, symbol: .named("symbol-nkyinkyim"), title: "Nkyinkyim", meaning: "Nkyinkyim means “twisting.” It is a symbol representing the tortuous nature of life’s journey.", description: "The design of Nkyinkyim depicts the tortuous nature of life’s journey. hese twists and turns require one to be versatile and resilient to survive.The proverb associated with this symbol is “Ɔbra kwan yɛ nkyinkyimii,” which literally means “Life’s journey is twisted.”Since a great number of proverbs are to the young and inexperienced, it is proper to construe this symbol as admonishing younger persons to brace up for what life may throw at them. Yes, they may not be aware of impending challenges but that is no excuse to resign to fate. By sheer force of will and determination, they can succeed.", pronunciation: "nkyinkyim", categories: ["Home", "Self"], isFavorite: true),
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

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = SymbolDetailsViewController()
        controller.symbols = symbol[indexPath.row]
        navigationController?.pushViewController(controller, animated: true)
    }
}

//MARK: - LAYOUT
extension FavoritesViewController {
    private func initializeView() {
        pageHeader.title = "Favorites"
        pageHeader.onProfileAction  = { [weak self] in
            self?.showProfileScreen()
        }
        
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
            $0.top == pageHeader.bottomAnchor
            $0.leading == view.leadingAnchor
            $0.trailing == view.trailingAnchor
            $0.bottom == view.bottomAnchor
        }
    }
}
