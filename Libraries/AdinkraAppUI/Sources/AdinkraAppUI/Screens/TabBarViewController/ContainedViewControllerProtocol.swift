import UIKit


protocol ContainedViewControllerProtocol: UIViewController {
    var selectedTabImage: UIImage { get }
    var itemTitle: String { get }
    var unselectedTabImage: UIImage { get }
}


//extension ContainedViewControllerProtocol {
//    var baseViewController: ContainerViewController {
//        guard let parent = parent as? ContainerViewController else {
//            fatalError("ContainedViewControllers must be attached to a containerViewController instance")
//        }
//        return parent
//    }
//}

extension ContainedViewControllerProtocol {
    func popToRoot() {
        guard let navController = self as? UINavigationController else { return }
        navController.popToRootViewController(animated: true)
    }
}
