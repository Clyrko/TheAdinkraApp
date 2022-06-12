import UIKit

class ActivityLoaderView: UIView {
    private var blurView: UIVisualEffectView!
    private var loadingIndicator: UIActivityIndicatorView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeView()
        addConstraint()
    }

    func startAnimating() {
        loadingIndicator.startAnimating()
    }

    func stopAnimating() {
        loadingIndicator.stopAnimating()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ActivityLoaderView {
    private func initializeView() {
        backgroundColor = .clear
        let blur = UIBlurEffect(style: .systemThinMaterialLight)
        blurView = .init(effect: blur)
        addSubview(blurView)
        dropCorner(15)
        clipsToBounds = true

        loadingIndicator = .init(style: .large)
        loadingIndicator.tintColor = .mainOrange
        loadingIndicator.color = .mainOrange
        loadingIndicator.hidesWhenStopped = true
        addSubview(loadingIndicator)
    }

    private func addConstraint() {
        blurView.pintToAllSidesOf(self)
        loadingIndicator.layout {
            $0.centerX == centerXAnchor
            $0.centerY == centerYAnchor
            $0.height |=| 80
            $0.width |=| 80
        }
    }
}
