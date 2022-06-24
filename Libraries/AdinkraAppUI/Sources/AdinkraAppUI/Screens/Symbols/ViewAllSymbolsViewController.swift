import Foundation
import UIKit

private enum Constants {
    static let itemSize = CGSize(width: 151, height: 141)
    static let horizontalInset: CGFloat = 28
}

class ViewAllSymbolsViewController: BaseViewController {
    private let navBar = PopOverNavigationBar()
    private var searchBar = StyleSearchBar()
    private var titleLabel: StyleLabel!
    private var collectionView: UICollectionView!
    
    var symbol: [SymbolPresentationModel] = [
        .init(id: 1, symbol: .named("symbol-aban"), title: "Aban", meaning: "A symbol of strength, seat of power, authority, and magnificence.", description: "Aban is the Akan word for “fortress” or “castle.”", pronunciation: "LOL", categories: ["Strength", "Power"], isFavorite: false),
        .init(id: 2, symbol: .named("symbol-abe-dua"), title: "Abe Dua", meaning: "Abe Dua means palm tree.", description: "The palm tree is a symbol resourcefulnees because many diverse products emanate from that single tree: wine, oil, brooms, roofing material, etc.", pronunciation: "LOL", categories: ["Wealth", "Resourcefulness"], isFavorite: false),
        .init(id: 3, symbol: .named("symbol-adinkrahene"), title: "Adinkrahene", meaning: "Adinkrahene means King of the Adinkra symbols. It is a symbol for authority, leadership, and charisma.", description: "The etymology of Adinkrahene is Adinkra + ɔhene, literally “Adinkra king” or “king of the Adinkras.” This symbol is reportedly the inspiration of the design of the other symbols. The elegant figure with three concentric circles is easy to draw and its abstract form connotes the importance of ideas and concepts, which are the essence of Adinkra–they are visual representations of important concepts in Akan philosophy.", pronunciation: "LOL", categories: ["Authority", "Leadership"], isFavorite: false),
        .init(id: 4, symbol: .named("symbol-adwo"), title: "Adwo", meaning: "Adwo means calmness. It is a symbol for peace, tranquility, and quiet.", description: "Keeping your inner peace and calmness, even if you face difficulties can alleviate the effects of chaos outside. Peace is of paramount importance, and you can achieve this by staying calm even in hard times.", pronunciation: "LOL", categories: ["Peace"], isFavorite: false),
        .init(id: 5, symbol: .named("symbol-agyindawuru"), title: "Agyindawuru", meaning: "Agyin’s gong. A symbol of faithfulness, alertness, and dutifulness", description: "Designed to commemorate the faithfulness of one Agyin who was a dutiful servant and gong-beater to the Asantehene.", pronunciation: "LOL", categories: ["Faith"], isFavorite: false),
        .init(id: 6, symbol: .named("symbol-akoben"), title: "Akoben", meaning: "Akoben means “war horn.” It is a symbol of a call to action, readiness to be called to action, readiness, and voluntarism.", description: "The war horn was blown to assemble the nation for war. Everybody had to be alert to interpret the message that it was being used to convey so as to respond with the right action.", pronunciation: "LOL", categories: ["War"], isFavorite: false),
        .init(id: 7, symbol: .named("symbol-akofena"), title: "Akofena", meaning: "sword of war symbol of courage, valor, and heroism", description: "The crossed swords were a popular motif in the heraldic shields of many former Akan states. In addition to recognizing courage and valor, the swords can represent legitimate state authority.", pronunciation: "LOL", categories: ["War"], isFavorite: false),
        .init(id: 8, symbol: .named("symbol-akoko-nan"), title: "Akoko Nan", meaning: "The foot of a hen. It is a symbol for nurturing coupled with discipline", description: "This Adinkra is from the proverb, “Akoko nan tia ba na enkum ba,” literally, “The foot of a hen steps on the child (chick) but it doesn’t kill the child (chick).”", pronunciation: "LOL", categories: ["Discipline"], isFavorite: false),
        .init(id: 9, symbol: .named("symbol-akoma"), title: "Akoma", meaning: "Akoma means “heart,” and it is a symbol of love, goodwill, patience, faithfulness, fondness, endurance, and consistency.", description: "Though the heart shape is a universal symbol representing love, it is also an Adinkra symbol with a slighty different meaning. As an Adinkra, the heart shape represents patience and tolerance. In Akan, “Nya akoma,” literally “Get a heart” means take heart–be patient. Conversely, one who is impatient is said not to have a heart: “Onni akoma.”", pronunciation: "LOL", categories: ["Love"], isFavorite: false),
        .init(id: 10, symbol: .named("symbol-akoma-ntoaso"), title: "Akoma Ntoaso", meaning: "Akoma Ntoaso means “the joining of hearts.” It could also mean “united hearts.” It is a symbol of agreement, togetherness and unity or a charter; an amplification of the concept of Akoma.", description: "Metaphorically, akoma ntoso embodies understanding and agreement, as well as harmony within communities. The physical symbol depicts four hearts linked together, emphasizing mutual sympathy and immortality of the soul. Additionally, akoma ntoso promotes unity among families and communities. The importance of these concepts is demonstrated in the African Burial Ground, where different people from different cultures are brought together by shared affections, memories of lost ones, and African culture.", pronunciation: "LOL", categories: ["Love"], isFavorite: false)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .styleWhite
        initializeView()
        layoutConstraint()
    }
}

//MARK: - COLLECTIONVIEW
extension ViewAllSymbolsViewController: UICollectionViewDataSource,UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        26
//    }
//
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        symbol.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SymbolCell.Identifier, for: indexPath) as? SymbolCell else { fatalError() }
        cell.setup(with: symbol[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return Constants.itemSize
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = SymbolDetailsViewController()
        controller.symbol = symbol[indexPath.row]
        navigationController?.pushViewController(controller, animated: true)
    }
}


//MARK: - LAYOUT
extension ViewAllSymbolsViewController {
    private func initializeView() {
        navBar.onBackAction = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        
        titleLabel = .init(
            with: .header2,
            textColor: .styleBlack,
            textAlignment: .left,
            text: "All Symbols"
        )
        
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionViewFlowLayout.scrollDirection = .vertical
        collectionViewFlowLayout.minimumLineSpacing = 30
        collectionViewFlowLayout.minimumInteritemSpacing = 20
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(SymbolCell.self, forCellWithReuseIdentifier: SymbolCell.Identifier)
        
        view.addSubview(navBar)
        view.addSubview(searchBar)
        view.addSubview(titleLabel)
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
        
        titleLabel.layout {
            $0.top == searchBar.bottomAnchor + 40
            $0.leading == view.leadingAnchor + Constants.horizontalInset
            $0.trailing == view.trailingAnchor - Constants.horizontalInset
        }
        
        collectionView.layout {
            $0.top == titleLabel.bottomAnchor + 24
            $0.leading == view.leadingAnchor + Constants.horizontalInset
            $0.trailing == view.trailingAnchor - 62
            $0.bottom == view.bottomAnchor
        }
    }
}
