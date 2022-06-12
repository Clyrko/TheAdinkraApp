import UIKit

extension UIFont {
    class func primary(weight: Weight, size: CGFloat)-> UIFont{
        switch weight{
        case .regular:
            return UIFont(name: "CabinSketch-Regular", size: size)!
        case .bold:
            return UIFont(name: "CabinSketch-Bold", size: size)!
        default: fatalError("No Fonts for \(weight) found")
        }
    }
    
    class func balsamiqSans(weight: Weight, size: CGFloat)-> UIFont{
        switch weight{
        case .regular:
            return UIFont(name: "BalsamiqSans-Regular", size: size)!
        case .bold:
            return UIFont(name: "BalsamiqSans-Bold", size: size)!
        default: fatalError("No Fonts for \(weight) found")
        }
    }
    
    class func montserrat(weight: Weight, size: CGFloat)-> UIFont{
        switch weight{
        case .regular:
            return UIFont(name: "Montserrat-Regular", size: size)!
        case .semibold:
            return UIFont(name: "Montserrat-SemiBold", size: size)!
        case .bold:
            return UIFont(name: "Montserrat-Bold", size: size)!
        default: fatalError("No Fonts for \(weight) found")
        }
    }
    
    public class func register() {
        registerFont("CabinSketch-Regular", fileExtension: "ttf")
        registerFont("CabinSketch-Bold", fileExtension: "ttf")
        registerFont("BalsamiqSans-Regular", fileExtension: "ttf")
        registerFont("BalsamiqSans-Bold", fileExtension: "ttf")
        registerFont("Montserrat-Regular", fileExtension: "ttf")
        registerFont("Montserrat-SemiBold", fileExtension: "ttf")
        registerFont("Montserrat-Bold", fileExtension: "ttf")
    }
    
    class func registerFont(_ name: String, fileExtension: String) {
        guard let fontURL = Bundle.module.url(forResource: name, withExtension: fileExtension) else {
            print("No font named \(name).\(fileExtension) was found in the module bundle")
            return
        }

        var error: Unmanaged<CFError>?
        CTFontManagerRegisterFontsForURL(fontURL as CFURL, .process, &error)
        print(error ?? "Successfully registered font: \(name)")
    }
}


