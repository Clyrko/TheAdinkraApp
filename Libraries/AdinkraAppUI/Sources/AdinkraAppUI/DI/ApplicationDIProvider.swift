import UIKit

public let applicationDIProvider = ApplicationDIProvider()

public class ApplicationDIProvider {
    private let viewControllerFactory = ViewControllerFactory()
}

extension ApplicationDIProvider {

    public func makeHomeViewController() -> UIViewController {
        viewControllerFactory.makeHomeViewController()
    }
    
    public func makeSymbolDetailsController() -> UIViewController {
        viewControllerFactory.makeSymbolDetailsViewController()
    }
    
    public func makeCategoriesViewController() -> UIViewController {
        viewControllerFactory.makeCategoriesViewController()
    }
    
    public func makeCategoryDetailsViewController() -> UIViewController {
        viewControllerFactory.makeCategoryDetailsViewController()
    }

    public func makeViewAllSymbolsViewController() -> UIViewController {
        viewControllerFactory.makeViewAllSymbolsViewController()
    }
    
    public func makeSignUpViewController() -> UIViewController {
        viewControllerFactory.makeSignUpViewController()
    }
    
    public func makeSignUpCompleteViewController() -> UIViewController {
        viewControllerFactory.makeSignUpCompleteViewController()
    }
    
    public func makeSignInViewController() -> UIViewController {
        viewControllerFactory.makeSignInViewController()
    }
    
    public func setBase(
        viewController: UIViewController,
        window: UIWindow? = nil
    ){
        guard let window = window ?? UIApplication.shared.appKeyWindow else { return }
        window.rootViewController = viewController
        window.makeKeyAndVisible()
    }
}
