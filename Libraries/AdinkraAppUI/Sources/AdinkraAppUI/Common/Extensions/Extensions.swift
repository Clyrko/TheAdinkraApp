import UIKit

public extension Int{
    func isInRange(specifiedRange:Int, with value:Int)->Bool{
        let val = (self - value).magnitude
        return val <= specifiedRange
    }
}


public extension UIDevice{
    
    class var idiom:UIUserInterfaceIdiom{
        return current.userInterfaceIdiom
    }
}


public extension CGFloat{
    static var fixedWidth:CGFloat{
        let idiom = UIDevice.current.userInterfaceIdiom
        if idiom == .phone{
            return UIScreen.main.bounds.width * 0.9
        }else if idiom == .pad{
            return 500
        }
        return 0
    }
    
    static var fixedWidthHG:CGFloat{
        
        let idiom = UIDevice.current.userInterfaceIdiom
        if idiom == .phone{
            return UIScreen.main.bounds.width * 0.7
        }else if idiom == .pad{
            return 350
        }
        return 0
    }
    
    static var fixedHeight:CGFloat{
        return UIScreen.main.bounds.height * 0.8
    }
    
    var halved:CGFloat{
        return self / 2
    }
        
    static func Angle(_ degree:CGFloat)-> CGFloat{
        return (.pi * degree) / 180
    }
    
    func by<T:BinaryFloatingPoint>(_ value:T)->CGFloat{
        return self * CGFloat(value)
    }
}


public extension Array{
    
    mutating func push(_ element:Element){
        if count > 10 {
            self = Array(dropFirst())
            append(element)
        }else{
            append(element)
        }
    }
    
    mutating func pop()->Element{
        return popLast()!
    }
    
    var isMulti:Bool{
        return count > 1
    }
}


public extension Int{
    
    func nsNumber()->NSNumber{
        return NSNumber(value: self)
    }
}


public extension UIScrollView{
    
    class func `default`()->UIScrollView{
        let scroll = UIScrollView(frame: .zero)
        scroll.bounces = true
        scroll.isScrollEnabled = true
        scroll.showsVerticalScrollIndicator = false
        return scroll
    }
}


public extension UIImageView{
    func setImageMaskColor(_ color:UIColor){
        let maskImage = image?.withRenderingMode(.alwaysTemplate)
        image = maskImage
        tintColor = color
    }
}


public extension UIImage{

    var byteSize:Int{
        return pngData()?.count ?? 0
    }


    func downSampleImage(size:CGSize)->UIImage?{
        guard let data = pngData() else {return nil}
        let option = [kCGImageSourceShouldCache: false] as CFDictionary
        guard let source = CGImageSourceCreateWithData(data as CFData, option) else {return nil}
        let scale = UIScreen.main.scale 
        let maxDimensPix = max(size.width, size.height) * scale
        let downOpts = [kCGImageSourceCreateThumbnailFromImageAlways: true,
                        kCGImageSourceShouldCacheImmediately: true, kCGImageSourceCreateThumbnailWithTransform: true,
                        kCGImageSourceThumbnailMaxPixelSize: maxDimensPix] as CFDictionary
        
        let cgImage = CGImageSourceCreateThumbnailAtIndex(source, 0, downOpts)
        return (cgImage != nil) ?  UIImage(cgImage: cgImage!) : nil
    }
}


public extension UIViewController {
    func add(_ child: UIViewController, to parentView:UIView? = nil) {
            addChild(child)
            if let v = parentView{
                v.addSubview(child.view)
            }else{
                view.addSubview(child.view)
            }
            child.didMove(toParent: self)
        }
        
    func removeFrom() {
            guard parent != nil else {
                return
            }
            
            willMove(toParent: nil)
            removeFromParent()
            
            view.removeFromSuperview()
        }
        
}

public func toSignficant(x:Double)->String{
   return String(format: "%.1f", x)
}

public func toSignficant(x:Float)->String{
    return String(format: "%.1f", x)
}

public func toSignficant(x:CGFloat)->String{
    return String(format: "%.1f", x)
}





