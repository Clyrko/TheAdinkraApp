import UIKit

extension UITableView {
    func dequeueCell<T: UITableViewCell>(at indexPath: IndexPath) -> T {
        dequeueReusableCell(withIdentifier: T.Identifier, for: indexPath) as! T
    }
}


extension UICollectionView {
    func dequeueCell<T: UICollectionViewCell>(at indexPath: IndexPath) -> T {
        dequeueReusableCell(withReuseIdentifier: T.Identifier, for: indexPath) as! T
    }
    
    func register<T: UICollectionViewCell>(cell type: T.Type){
        register(type, forCellWithReuseIdentifier: type.Identifier)
    }
}


extension UITableView {
    func register<T: UITableViewCell>(cell type: T.Type){
        register(type, forCellReuseIdentifier: type.Identifier)
    }
    
    func firstVisibleCell<T: UITableViewCell>() -> T? {
        visibleCells.first{ $0 is T } as? T
    }
}
