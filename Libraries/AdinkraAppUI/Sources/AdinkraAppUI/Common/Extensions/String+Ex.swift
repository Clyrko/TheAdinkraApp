import UIKit


public extension String {
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
        
        return ceil(boundingBox.height)
    }
    
    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
        
        return ceil(boundingBox.width)
    }
    
    func width(withConstrainedHeight height: CGFloat, attributes:[NSAttributedString.Key:Any]) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
        
        return ceil(boundingBox.width)
    }
    
    func height(withConstrainedWidth width: CGFloat, attributes:[NSAttributedString.Key:Any]) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
        
        return ceil(boundingBox.height)
    }
    
    var isValidEmail: Bool {
        let detector = try? NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        let range = NSRange(location: 0, length: count)
        let firstMatch = detector?.firstMatch(in: self, options: .reportCompletion, range: range)
        let email = firstMatch?.url?.absoluteString.replacingOccurrences(of: "mailto:", with: "")
        return firstMatch?.range.location != NSNotFound && firstMatch?.url?.scheme == "mailto" && email == self
    }
    
    
}

extension AnyHashable{
    
    public static let info = "Info"
}
