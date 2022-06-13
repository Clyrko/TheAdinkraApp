import UIKit


class ContainedNavigationViewController: UINavigationController, ContainedViewControllerProtocol {
    private let sidebarItem: BaseTabBarItem
    
    init(
        rootViewController: UIViewController,
        sidebarItem: BaseTabBarItem
    ) {
        self.sidebarItem = sidebarItem
        super.init(rootViewController: rootViewController)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isNavigationBarHidden = true
    }
}

extension ContainedNavigationViewController {
    var itemTitle: String { sidebarItem.title }
    var unselectedTabImage: UIImage { sidebarItem.image }
    var selectedTabImage: UIImage { sidebarItem.selectedImage }
}
