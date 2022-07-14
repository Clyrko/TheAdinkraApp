import UIKit
import AdinkraAppPresentation
import CoreML
import Vision

class ViewControllerFactory {
    
    private let tabBarItemProvider: TabBarItemProvider
    private let ftuxCardItemProvider: FTUXTourItemProvider
    
    init(
        with itemProvider: TabBarItemProvider,
        ftuxCardItemProvider: FTUXTourItemProvider
    ) {
        self.tabBarItemProvider = itemProvider
        self.ftuxCardItemProvider = ftuxCardItemProvider
    }

         func makeApplicationBaseScreen() -> UIViewController {
             let home = ContainedNavigationViewController(
                 rootViewController: makeHomeViewController(),
                 sidebarItem: tabBarItemProvider.home
             )
             
             let store = ContainedNavigationViewController(
                 rootViewController: makeStoreViewController(),
                 sidebarItem: tabBarItemProvider.store
             )
             
             let favorites = ContainedNavigationViewController(
                 rootViewController: makeFavoritesViewController(),
                 sidebarItem: tabBarItemProvider.favorites
             )
             
             let settings = ContainedNavigationViewController(
                 rootViewController: makeSettingsViewController(),
                 sidebarItem: tabBarItemProvider.settings
             )
             
             return BaseApplicationViewController(
                 viewControllers: [
                     home, store, favorites, settings
                 ],
                 ftuxCardItems: [
                     ftuxCardItemProvider.home,
                     ftuxCardItemProvider.store,
                     ftuxCardItemProvider.favorites,
                     ftuxCardItemProvider.settings
                 ]
             )
         }

         func makeHomeViewController() -> BaseViewController {
             HomeViewController()
//             ViewAllSymbolsViewController()
         }

         func makeStoreViewController() -> BaseViewController {
             StoreViewController()
         }

         func makeFavoritesViewController() -> BaseViewController {
             FavoritesViewController()
         }

         func makeSettingsViewController() -> BaseViewController {
             SettingsViewController()
         }

    
//    func makeHomeViewController() -> UIViewController {
//        let navigationController = UINavigationController(rootViewController: HomeViewController())
//        navigationController.isNavigationBarHidden = true
//        return navigationController
//    }
    
    func makeScanViewController(model: VNCoreMLModel) -> ScanViewController {
        .init(with: model)
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
    
    func makeProfileViewController() -> ProfileViewController {
        .init()
    }
    
    func makeStoreItemViewController() -> StoreItemViewController {
        .init()
    }
    
    func makeAddToCartViewController() -> AddToCartViewController {
        .init()
    }
}
