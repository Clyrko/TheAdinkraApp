import UIKit

private enum Constants {
    static let placeholderFontSize: CGFloat = 12
    static let textfieldInset = UIEdgeInsets(top: 4, left: 16, bottom: 4, right: 8)
    static let placeHolderInset = UIEdgeInsets(top: 2, left: 4, bottom: 2, right: 4)
    static let containerInsets: UIEdgeInsets = .init(top: 4, left: 4, bottom: 4, right: 4)
    static let iconSize = CGSize(width: 24, height: 24)
    static let horizontalInset: CGFloat = 16
    static let verticalInset: CGFloat = 16
    static let bottomVerticalInset: CGFloat = 3
    static let placeholderHeight: CGFloat = 20
    static let borderWidth: CGFloat = 1
    static let errorBorderWidth: CGFloat = 2
    static let cornerRadius: CGFloat = 8
    static let numberOfLines: Int = 1
}

class StyleTextField: UIView {
    private enum State {
        case normal, editing, error
    }
    private var textField: UITextField!
    private var placeholderLabel: StyleLabel!
    private let placeholderLabelContainer = UIView()
    private let icon = UIButton()
    private var placeholderConstraints = ConstraintHolder()
    private let shadowContainer = UIView()
    let container = UIView()
    private var bottomLabel: StyleLabel!
    private var state: State = .normal
    private var hasSetShadows = false
    private var forwardEditActionButton = UIButton()
    
    var onTextChangeAction: Closure.SingleInput<String>?
    var didEndEditing: Closure.SingleInput<String>?
    
    //Get Rid of this in near future
    var onforwardsEditAction: Closure.Block? {
        didSet {
            if onforwardsEditAction != nil {
                setupforwardEditAction()
            }else{
                forwardEditActionButton.removeFromSuperview()
            }
        }
    }
    
    var text: String {
        set {
            textField.text = newValue
        }
        get {
            return textField.text ?? ""
        }
    }
    
    var style: StyleLabel.Style? {
        didSet { textField.font = style?.font }
    }
    
    var borderStyle: UITextField.BorderStyle = .roundedRect {
        didSet {
            textField.borderStyle = borderStyle
        }
    }
    
    var textColor: UIColor = .mainOrange {
        didSet {
            textField.textColor = textColor
            textField.tintColor = textColor
        }
    }
    
    var iconImage: UIImage? {
        didSet {
            icon.isHidden = iconImage == nil
            icon.setImage(iconImage, for: .normal)
        }
    }
    
    var keyBoardType: UIKeyboardType = .default {
        didSet{ textField.keyboardType = keyBoardType }
    }
    
    var isSecureEntry: Bool = false {
        didSet{
            textField.isSecureTextEntry = isSecureEntry
            iconImage = isSecureEntry ? .named("icon-24-eye-slash") : nil
        }
    }
    
    var placeholder: String? {
        didSet{
            textField.placeholder = placeholder
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeView()
        layoutConstraint()
    }

    override func resignFirstResponder() -> Bool {
        super.resignFirstResponder()
        return textField.resignFirstResponder()
    }
    
    func set(_ text: String) {
        textField.text = text
    }
    
    func set(error: String) {
        state = .error
        bottomLabel.textColor = .systemRed
        bottomLabel.text = error
        UIView.animate(withDuration: 0.35, delay: .zero, options: .curveEaseInOut) {
            self.bottomLabel.alpha = 1
            self.layoutIfNeeded()
        }
    }
    
    func clearErrors() {
        if state == .error {
            bottomLabel.textColor = textColor
            bottomLabel.text = .init()
            self.bottomLabel.alpha = .zero
            state = .normal
        }
    }
    
    func isValid(length: Int = 6) -> Bool {
        if text.count >= length {
            return true
        } else {
            return false
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func onTapAction(sender: UIControl){
        if sender == forwardEditActionButton {
            self.onforwardsEditAction?()
            return
        }
        isSecureEntry.toggle()
    }
    
    private func setupforwardEditAction() {
        addSubview(forwardEditActionButton)
        forwardEditActionButton.pintToAllSidesOf(self)
        forwardEditActionButton.addTarget(self, action: #selector(onTapAction(sender:)), for: .touchUpInside)
    }
}

extension StyleTextField {
    private func initializeView(){
        backgroundColor = .clear
        clipsToBounds = false

        container.backgroundColor = .systemGray
        container.layer.borderWidth = Constants.borderWidth
        container.layer.borderColor = UIColor.clear.cgColor
        container.dropCorner(Constants.cornerRadius)
        
        textField = UITextField(frame: .zero)
        textField.font = StyleLabel.Style.bodyMainRegular.font
        textField.adjustsFontSizeToFitWidth = true
        textField.keyboardType = keyBoardType
        textField.delegate = self
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.textColor = textColor
        textField.tintColor = textColor
        textField.returnKeyType = .done
        
        placeholderLabel = .init(
            with: .bodyBalsamiqBold,
            textColor: .systemGray,
            numberOfLines: Constants.numberOfLines
        )
        
        placeholderLabelContainer.backgroundColor = .clear
        placeholderLabelContainer.addSubview(placeholderLabel)
        placeholderLabelContainer.alpha = .zero
        placeholderLabelContainer.translatesAutoresizingMaskIntoConstraints = false
        
        bottomLabel = .init(
            with: .bodyBalsamiqBold,
            textColor: .systemRed,
            numberOfLines: Constants.numberOfLines
        )
        bottomLabel.alpha = .zero
        
        icon.contentMode = .scaleAspectFit
        icon.isHidden = true
        icon.addTarget(self, action: #selector(onTapAction(sender:)), for: .touchUpInside)
        
        shadowContainer.backgroundColor = .clear
        shadowContainer.dropCorner(Constants.cornerRadius)
        
        addSubview(placeholderLabelContainer)
        addSubview(bottomLabel)
        addSubview(shadowContainer)
        container.addSubview(textField)
        container.addSubview(icon)
        shadowContainer.addSubview(container)
    }
    
    private func layoutConstraint(){
        textField.pintToAllSidesOf(container, insets: Constants.textfieldInset)
        placeholderLabel.pintToAllSidesOf(placeholderLabelContainer, insets: .init(top: 2, left: 4, bottom: 2, right: 4))
        placeholderConstraints.centerY = placeholderLabelContainer.centerYAnchor.constraint(equalTo: centerYAnchor)
        placeholderConstraints.leading = placeholderLabelContainer.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.horizontalInset)
        placeholderConstraints.height = placeholderLabelContainer.heightAnchor.constraint(equalToConstant: Constants.placeholderHeight)
        placeholderConstraints.activate()
        shadowContainer.pintToAllSidesOf(self)
        container.pintToAllSidesOf(shadowContainer, insets: Constants.containerInsets)
        icon.layout {
            $0.centerY == textField.centerYAnchor
            $0.trailing == trailingAnchor - Constants.horizontalInset
            $0.height |=| Constants.iconSize.height
            $0.width |=| Constants.iconSize.width
        }
        bottomLabel.layout {
            $0.leading == leadingAnchor + Constants.horizontalInset
            $0.top == bottomAnchor + Constants.bottomVerticalInset
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        guard !hasSetShadows else { return }
        addShadow()
        hasSetShadows = true
        shadowContainer.layer.shadowOpacity = .zero
    }
    
    private func addShadow() {
        let path = UIBezierPath(roundedRect: shadowContainer.bounds, cornerRadius: 8)
        shadowContainer.layer.shadowRadius = .zero
        shadowContainer.layer.shadowColor = UIColor(red: 0.106, green: 0.341, blue: 0.314, alpha: 0.2).cgColor
        shadowContainer.layer.shadowOpacity = 1
        shadowContainer.layer.shadowOffset = .zero
        shadowContainer.layer.shadowPath = path.cgPath
    }
}

extension StyleTextField: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        clearErrors()
        state = .editing
        icon.isHidden = false
        placeholderConstraints.deactivate()
        placeholderConstraints.centerY = placeholderLabelContainer.centerYAnchor.constraint(equalTo: topAnchor)
        placeholderConstraints.activate()
        UIView.animate(withDuration: 0.35, delay: .zero, options: .curveEaseInOut) {
            self.placeholderLabelContainer.alpha = 1
            self.container.borderlize(width: 1, color: .mainOrange)
            self.shadowContainer.layer.shadowOpacity = 1
            self.layoutIfNeeded()
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        state = .normal
        if !textField.hasText {
            icon.isHidden = true
        }
        placeholderConstraints.deactivate()
        placeholderConstraints.centerY = placeholderLabelContainer.centerYAnchor.constraint(equalTo: centerYAnchor)
        placeholderConstraints.activate()
        UIView.animate(withDuration: 0.35, delay: .zero, options: .curveEaseInOut) {
            self.placeholderLabelContainer.alpha = .zero
            self.shadowContainer.layer.shadowOpacity = .zero
            self.container.borderlize(color: .clear)
            self.layoutIfNeeded()
        }
        
        if self.isSecureEntry {
            if self.isValid() {
                state = .normal
                placeholderLabel.textColor = textColor
                container.borderlize(width: Constants.borderWidth, color: textColor)
                bottomLabel.textColor = textColor
            } else {
                state = .editing
            }
        }
        guard let text = textField.text, text.isNotEmpty else {
            didEndEditing?(text)
            return
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        clearErrors()
        state = .editing
        let text = NSString(string: text).replacingCharacters(in: range, with: string)
        onTextChangeAction?(text)
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        endEditing(true)
    }
}
