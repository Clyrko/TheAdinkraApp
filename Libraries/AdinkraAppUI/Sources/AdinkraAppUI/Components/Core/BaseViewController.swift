import Combine
//import DrugViuDomain
import UIKit

class BaseViewController: UIViewController {
    var subscriptions = Set<AnyCancellable>()
    
    private let loader: ActivityLoaderView = .init()
    private let overlay: UIView = {
        let view = UIView(frame: UIScreen.main.bounds)
        view.backgroundColor = .styleBlack.withAlphaComponent(0.2)
        return view
    }()
    
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func showLoader() {
        UIView.transition(with: view, duration: 0.3, options: .transitionCrossDissolve) {
            self.view.addSubview(self.overlay)
            self.view.addSubview(self.loader)
            self.setLoaderConstraints()
        } completion: { finished in
            if finished { self.loader.startAnimating() }
        }
    }

    func hideLoader() {
        UIView.transition(with: view, duration: 0.3, options: .transitionCrossDissolve) {
            self.loader.removeFromSuperview()
            self.overlay.removeFromSuperview()
        } completion: { finished in
            if finished { self.loader.stopAnimating() }
        }
    }
    
    func showAlert(
        with title: String,
        message: String,
        dismissTitle: String = "Cancel",
        actions: [UIAlertAction]
    ){
        let controller = UIAlertController(title: title, message: message, preferredStyle: .alert)
        controller.addAction(.init(title: dismissTitle, style: .default, handler: nil))
        actions.forEach(controller.addAction(_:))
        controller.view.tintColor = .mainOrange
        present(controller, animated: true)
    }
    
    private func setLoaderConstraints() {
        loader.layout {
            $0.centerX == view.centerXAnchor
            $0.centerY == view.centerYAnchor
            $0.height |=| 300
            $0.width |=| 300
        }
    }
    
    deinit {
//        AppLogger.log(.ui, .info, "Deallocated View \(Self.Identifier)")
    }
}
