import UIKit
import AdinkraAppPresentation
import CoreML
import Vision

public let applicationDIProvider = ApplicationDIProvider()

public class ApplicationDIProvider {
    private let transitionDuration: CGFloat = 0.35
    private let viewControllerFactory: ViewControllerFactory
    public var adinkraModel: VNCoreMLModel?
    //    private let viewModelFactory: ViewModelFactoryProtocol
    
    init() {
        //        viewModelFactory = ViewModelFactory(with: .standard)
        viewControllerFactory = .init(
            with: .init(),
            ftuxCardItemProvider: .init()
        )
    }
}

extension ApplicationDIProvider {
    
    public func makeRootViewController() -> UIViewController {
        makeApplicationBaseViewController()
    }
    
    public func makeApplicationBaseViewController() -> UIViewController {
        return viewControllerFactory.makeApplicationBaseScreen()
    }
    
    //    public func makeHomeViewController() -> UIViewController {
    //        viewControllerFactory.makeHomeViewController()
    //    }
    
    public func makeScanViewController() -> UIViewController {
        guard let model = adinkraModel else {
            fatalError()
        }
        return viewControllerFactory.makeScanViewController(model: model)
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
    
    public func makeProfileViewController() -> UIViewController {
        viewControllerFactory.makeProfileViewController()
    }
    
    public func makeStoreItemViewController() -> UIViewController {
        viewControllerFactory.makeStoreItemViewController()
    }
    
    public func makeAddToCartViewController() -> UIViewController {
        viewControllerFactory.makeAddToCartViewController()
    }
    
    public func setBase(
        viewController: UIViewController,
        window: UIWindow? = nil,
        animated: Bool = false
    ) {
        guard let window = window ?? UIApplication.shared.appKeyWindow else { return }
        window.rootViewController = viewController
        window.makeKeyAndVisible()
        if animated {
            UIView.transition(
                with: window,
                duration: transitionDuration,
                options: .transitionCrossDissolve,
                animations: { }
            )
        }
    }
}
