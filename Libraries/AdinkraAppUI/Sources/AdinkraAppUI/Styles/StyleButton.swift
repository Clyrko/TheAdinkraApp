import UIKit

private enum Constants {
    static let horizontalInset: CGFloat = 16
    static let iconSize = CGSize(width: 24, height: 24)
    static let textHeight: CGFloat = 30
}

class StyleButton: UIControl {
    private var titleLabel: StyleLabel!
    var iconImageView: UIImageView!
    private let style: Style
    private let container = UIView()
    private var title: String? {
        didSet { titleLabel.text = title }
    }
    var titleColor: UIColor? {
        didSet { titleLabel.textColor = titleColor }
    }

    var text: String? {
        didSet { titleLabel.text = text }
    }

    var canHighlight: Bool = true

    override var isHighlighted: Bool {
        didSet { updateForIsHighlighted() }
    }

    override var isEnabled: Bool {
        didSet { updateForEnabled() }
    }

    override var tintColor: UIColor! {
        didSet { iconImageView.setImageMaskColor(tintColor) }
    }

    var onTapAction: Closure.Block?

    init(
        with style: Style,
        title: String? = nil
    ){
        self.style = style
        self.title = title
        super.init(frame: .zero)
        initializeView()
        layoutConstraint()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func updateForIsHighlighted() {
        guard canHighlight else { return }
        switch style {
        case .primaryDefault, .primaryIconLeft, .primaryIconRight, .indicator:
            backgroundColor = isHighlighted ? .systemOrange : .mainOrange
        case .secondaryDefault, .secondaryIconRight, .secondaryIconLeft:
            backgroundColor = isHighlighted ? .systemGray  : .styleWhite
        }
    }

    private func updateForEnabled() {
        switch style {
        case .primaryDefault, .primaryIconLeft, .primaryIconRight:
            backgroundColor = isEnabled ? .mainOrange : .systemGray
            titleLabel.textColor = isEnabled ? .styleWhite : .systemGray
        case .secondaryDefault, .secondaryIconRight, .secondaryIconLeft:
            backgroundColor = isEnabled ? .systemGray  : .styleWhite
        case .indicator:
            backgroundColor = isEnabled ? .mainOrange : .systemGray
            iconImageView.setImageMaskColor(isEnabled ?.styleWhite : .systemGray)
        }
    }

    @objc private func onTap(){
        onTapAction?()
    }
}

extension StyleButton {
    private func initializeView() {
        addTarget(self, action: #selector(onTap), for: .touchUpInside)
        titleLabel = .init(
            with: .bodyMainRegular,
            textColor: .styleWhite,
            textAlignment: .center
        )
        iconImageView = .init()
        switch style {
        case .primaryDefault:
            backgroundColor = .mainOrange
            titleLabel.textColor = .styleWhite
            titleLabel.text = title
            addSubview(titleLabel)
        case .primaryIconRight, .primaryIconLeft:
            titleLabel.text = title
            backgroundColor = .mainOrange
            titleLabel.textColor = .white
            iconImageView.image = .named(style == .primaryIconLeft ? "icon-24-check" : "icon-24-arrow-right")
            iconImageView.setImageMaskColor(.styleWhite)
            container.backgroundColor = .clear
            container.isUserInteractionEnabled = false
            container.addSubview(iconImageView)
            container.addSubview(titleLabel)
            addSubview(container)
        case .secondaryDefault:
            titleLabel.text = title
            backgroundColor = .styleWhite
            titleLabel.textColor = .mainOrange
            borderlize(width: 1, color: .systemGray)
            addSubview(titleLabel)
        case .secondaryIconRight, .secondaryIconLeft:
            titleLabel.text = title
            backgroundColor = .styleWhite
            titleLabel.textColor = .mainOrange
            iconImageView.image = .named(style == .primaryIconLeft ? "icon-24-check" : "icon-24-arrow-right")
            iconImageView.setImageMaskColor(.mainOrange)
            container.backgroundColor = .clear
            container.isUserInteractionEnabled = false
            container.addSubview(iconImageView)
            container.addSubview(titleLabel)
            addSubview(container)
        case .indicator:
            backgroundColor = .mainOrange
//            iconImageView.image = .named("icon-24-arrow-right")
            iconImageView.setImageMaskColor(.styleWhite)
            addSubview(iconImageView)
        }
    }

    func layoutConstraint() {
        switch style {
        case .primaryDefault, .secondaryDefault:
            titleLabel.layout {
                $0.leading == leadingAnchor + Constants.horizontalInset
                $0.trailing == trailingAnchor - Constants.horizontalInset
                $0.centerY == centerYAnchor
            }
        case .primaryIconRight, .primaryIconLeft,
                .secondaryIconRight, .secondaryIconLeft:
            iconImageView.layout {
                $0.width |=| Constants.iconSize.width
                $0.height |=| Constants.iconSize.height
                if style == .primaryIconRight || style == .secondaryIconRight {
                    $0.leading == titleLabel.trailingAnchor + 8
                    $0.trailing == container.trailingAnchor
                }else{
                    $0.leading == container.leadingAnchor
                }
                $0.centerY == container.centerYAnchor
            }
            titleLabel.layout {
                $0.height |=| Constants.textHeight
                $0.top == container.topAnchor
                $0.bottom == container.bottomAnchor
                if style == .primaryIconRight || style == .secondaryIconRight {
                    $0.leading == container.leadingAnchor
                }else{
                    $0.leading == iconImageView.trailingAnchor + 8
                    $0.trailing == container.trailingAnchor
                }
            }
            container.layout {
                $0.centerX == centerXAnchor
                $0.centerY == centerYAnchor
            }
        case .indicator:
            iconImageView.layout {
                $0.centerX == centerXAnchor
                $0.centerY == centerYAnchor
                $0.width |=| Constants.iconSize.width
                $0.height |=| Constants.iconSize.height
            }
        }
    }
}

extension StyleButton {
    enum Style {
        case primaryDefault
        case primaryIconRight
        case primaryIconLeft
        case secondaryDefault
        case secondaryIconRight
        case secondaryIconLeft
        case indicator
    }
}
