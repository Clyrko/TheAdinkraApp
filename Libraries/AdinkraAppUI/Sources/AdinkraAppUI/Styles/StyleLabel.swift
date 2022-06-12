import UIKit

class StyleLabel: UILabel {
    private let insets: UIEdgeInsets
    var style: Style!
    
    var contentWidth: CGFloat {
        text?.width(withConstrainedHeight: .infinity, font: font) ?? .zero
    }
    
    init(
        with style: Style,
        textColor: UIColor,
        textAlignment: NSTextAlignment = .natural,
        numberOfLines: Int = .zero,
        lineBreakMode: NSLineBreakMode = .byWordWrapping,
        text: String? = nil,
        insets: UIEdgeInsets = .zero
    ) {
        self.style = style
        self.insets = insets
        super.init(frame: .zero)
        self.font = style.font
        self.textColor = textColor
        self.textAlignment = textAlignment
        self.numberOfLines = numberOfLines
        self.lineBreakMode = lineBreakMode
        if text != nil {
            self.text = text
        }
    }
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: insets))
    }
    
    private override init(frame: CGRect) {
        self.insets = .zero
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension StyleLabel {
    enum Style {
        case header1
        case header2
        case bodyMainRegular
        case headerBalsamiqRegular
        case bodyBalsamiqBold
    }
}

extension StyleLabel.Style {
    var font: UIFont {
        switch self {
        case .header1:
            return .primary(weight: .bold, size: 20)
        case .header2:
            return .primary(weight: .bold, size: 18)
        case .bodyMainRegular:
            return .primary(weight: .regular, size: 16)
        case .bodyBalsamiqBold:
            return .balsamiqSans(weight: .bold, size: 18)
        case .headerBalsamiqRegular:
            return .balsamiqSans(weight: .regular, size: 35)
        }
    }
}
