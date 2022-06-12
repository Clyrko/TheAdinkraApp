import UIKit

public extension UILabel {
    class func makeLabel(
        font: UIFont,
        textColor: UIColor,
        textAlignment: NSTextAlignment = .natural,
        numberOfLines: Int = .zero,
        lineBreakMode: NSLineBreakMode = .byWordWrapping,
        text: String? = nil
    ) -> UILabel {
        let label = UILabel()
        label.font = font
        label.textColor = textColor
        label.textAlignment = textAlignment
        label.numberOfLines = numberOfLines
        label.lineBreakMode = lineBreakMode
        if text != nil {
            label.text = text
        }
        return label
    }
}
