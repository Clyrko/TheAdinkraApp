import UIKit

private enum Constants {
    static let titleFontSize: CGFloat = 14
    static let numberOfLines: Int = 1
    static let horizontalInset: CGFloat = 8
    static let verticalInset: CGFloat = 8
    static let imageSize = CGSize(width: 20, height: 20)
    static let cornerRadius: CGFloat = 9
    static let estimatedItemSize = CGSize(width: 90, height: 55)
}

class TabBarItem: UIControl {
    private var titleLabel: StyleLabel!
    private var imageView: UIImageView!
    private var widthConstraint: NSLayoutConstraint?
    private var heightConstraint: NSLayoutConstraint?
    private var imageWidthConstraint: NSLayoutConstraint?
    private var imageHeightConstraint: NSLayoutConstraint?
    
    var uiModel: UIModel
    var onSelected: Closure.SingleInput<Int>?
    
    override var isSelected: Bool {
        didSet { update() }
    }
    
    init(model: UIModel) {
        self.uiModel = model
        super.init(frame: .zero)
        initializeView()
        addConstraint()
        update()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func update(){
        let model = uiModel
        titleLabel.text = model.title
        titleLabel.textColor = isSelected ? model.selectedTint : model.defaultTint
        imageView.image = isSelected ? model.selectedImage : model.image
    }
    
    @objc private func onTapAction(sender: UIControl){
        onSelected?(uiModel.index)
    }
    
    func hide() {
        widthConstraint?.constant = .zero
        heightConstraint?.constant = .zero
        imageHeightConstraint?.constant = .zero
        imageWidthConstraint?.constant = .zero
    }
    
    func show() {
        widthConstraint?.constant = Constants.estimatedItemSize.width
        heightConstraint?.constant = Constants.estimatedItemSize.height
        imageHeightConstraint?.constant = Constants.imageSize.height
        imageWidthConstraint?.constant = Constants.imageSize.width
    }
}

extension TabBarItem {
    private func initializeView(){
        backgroundColor = .styleWhite
        addTarget(self, action: #selector(onTapAction(sender:)), for: .touchUpInside)
        
        titleLabel = .init(
            with: .bodyBalsamiqBold,
            textColor: .styleBlack,
            textAlignment: .center,
            numberOfLines: 1
        )
        
        imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        
        addSubview(titleLabel)
        addSubview(imageView)
    }
    
    private func addConstraint(){
        layout{
            $0.width |=| Constants.estimatedItemSize.width
            $0.height |=| Constants.estimatedItemSize.height
        }
        
        imageView.layout{
            $0.centerX == centerXAnchor
            $0.bottom == titleLabel.topAnchor - 4 // Constants.verticalInset
            $0.height |=| Constants.imageSize.height
            $0.width |=| Constants.imageSize.width
        }
        
        titleLabel.layout{
            $0.bottom == bottomAnchor - Constants.verticalInset
            $0.leading == leadingAnchor
            $0.trailing == trailingAnchor
        }
    }
}


extension TabBarItem {
    struct UIModel {
        let index: Int
        let title: String
        let image: UIImage
        let selectedImage: UIImage
        let selectedTint: UIColor
        let defaultTint: UIColor
    }
}
