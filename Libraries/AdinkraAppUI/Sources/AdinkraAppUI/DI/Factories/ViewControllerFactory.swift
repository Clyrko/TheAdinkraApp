import UIKit
class ViewControllerFactory {
    
    func makeHomeViewController() -> UIViewController {
        let navigationController = UINavigationController(rootViewController: HomeViewController())
        navigationController.isNavigationBarHidden = true
        return navigationController
    }
    
    func makeSymbolDetailsViewController() -> SymbolDetailsViewController {
        .init()
    }
    
    func makeCategoriesViewController() -> CategoriesViewController {
        .init()
    }
    
    func makeCategoryDetailsViewController() -> CategoryDetailsViewController {
        .init()
    }
    
    func makeViewAllSymbolsViewController() -> ViewAllSymbolsViewController {
        .init()
    }
    
    func makeSignUpViewController() -> SignUpViewController {
        .init()
    }
    
    func makeSignUpCompleteViewController() -> SignUpCompleteViewController {
        .init()
    }
    
    func makeSignInViewController() -> SignInViewController {
        .init()
    }
    
}
