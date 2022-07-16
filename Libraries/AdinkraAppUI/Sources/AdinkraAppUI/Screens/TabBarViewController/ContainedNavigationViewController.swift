//import UIKit
//
//
//class ContainedNavigationViewController: UINavigationController, ContainedViewControllerProtocol {
//    private let sidebarItem: BaseTabBarItem
//
//    init(
//        rootViewController: UIViewController,
//        sidebarItem: BaseTabBarItem
//    ) {
//        self.sidebarItem = sidebarItem
//        super.init(rootViewController: rootViewController)
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        isNavigationBarHidden = true
//    }
//}
//
//extension ContainedNavigationViewController {
//    var itemTitle: String { sidebarItem.title }
//    var unselectedTabImage: UIImage { sidebarItem.image }
//    var selectedTabImage: UIImage { sidebarItem.selectedImage }
//}

import UIKit

class ContainedNavigationViewController: UINavigationController, ContainedViewControllerProtocol {
    private let sidebarItem: BaseTabBarItem
    private let rootViewController: UIViewController
    
    private var parentTabBarController: BaseApplicationViewController? {
        return parent as? BaseApplicationViewController
    }
    
    init(
        rootViewController: UIViewController,
        sidebarItem: BaseTabBarItem
    ) {
        self.sidebarItem = sidebarItem
        self.rootViewController = rootViewController
        super.init(rootViewController: rootViewController)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isNavigationBarHidden = true
        delegate = self
        navigationBar.barStyle = .black
    }
}

extension ContainedNavigationViewController: UINavigationControllerDelegate {
    func navigationController(
        _ navigationController: UINavigationController,
        willShow viewController: UIViewController, animated: Bool
    ) {
        guard viewController != rootViewController, viewController.hidesBottomBarWhenPushed else {
            parentTabBarController?.showTabBar()
            return
        }
        parentTabBarController?.hideTabBar()
        
    }
}

extension ContainedNavigationViewController {
    var itemTitle: String { sidebarItem.title }
    var unselectedTabImage: UIImage { sidebarItem.image }
    var selectedTabImage: UIImage { sidebarItem.selectedImage }
}
