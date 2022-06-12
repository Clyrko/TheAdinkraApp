import UIKit

extension String{
    
    func addingAttribute(_ attribute:AttributedText.Attribute)->AttributedText{
        var attr = AttributedText(string: self)
        return attr.attributing(attribute)
    }
    
    func attributing(_ attributes:[AttributedText.Attribute])->NSAttributedString{
        var attrs:[NSAttributedString.Key:Any] = [:]
        attributes.forEach{
            switch $0{
            case .style(let style):
                attrs.updateValue(style.font, forKey: .font)
            case .font(let font):
                attrs.updateValue(font, forKey: .font)
                break
            case .kern(let k):
                attrs.updateValue(k, forKey: .kern)
                break
            case .textColor(let c):
                attrs.updateValue(c, forKey: .foregroundColor)
                break
            case .obliqueness(let val):
                attrs.updateValue(NSNumber(value: Float(val)), forKey: .obliqueness)
                break
            case .backgroundColor(let color):
                attrs.updateValue(color ?? .clear, forKey: .backgroundColor)
                break
            case .expansion(let val):
                attrs.updateValue(NSNumber(value: Float(val)), forKey: .expansion)
                break
            case .baselineOffset(let val):
                attrs.updateValue(NSNumber(value: Float(val)), forKey: .baselineOffset)
                break
            case .ligature(let ligature):
                attrs.updateValue(NSNumber(value: ligature.value), forKey: .ligature)
                break
            case .strikethroughColor(let color):
                attrs.updateValue(color, forKey: .strikethroughColor)
                break
            case .strokeColor(let color):
                attrs.updateValue(color, forKey: .strokeColor)
                break
            case .underlineColor(let color):
                attrs.updateValue(color, forKey: .underlineColor)
                break
            case .strokeWidth(let val):
                attrs.updateValue(NSNumber(value: Float(val)), forKey: .ligature)
                break
            case .strikethroughStyle(let val):
                attrs.updateValue(NSNumber(value: val), forKey: .strikethroughStyle)
                break
            case .underlineStyle(let val):
                attrs.updateValue(NSNumber(value: val), forKey: .underlineStyle)
                break
            case .link(let link):
                attrs.updateValue(link.linkURL, forKey: .link)
                break
            case .shadow(let shadow):
                attrs.updateValue(shadow.getShadow, forKey: .shadow)
                break
            case .textEffect(let effect):
                attrs.updateValue(effect.value, forKey: .textEffect)
                break
            case .verticalGlyphForm(let glyph):
                attrs.updateValue(glyph.rawValue, forKey: .verticalGlyphForm)
                break
            case .writingDirection(let direction):
                attrs.updateValue(direction.attributableValues, forKey: .writingDirection)
                break
            case .attachment(let attachment):
                attrs.updateValue(attachment, forKey: .attachment)
                break
            case .lineSpacing(let spacing):
                if let paragraph = attrs[.paragraphStyle] as? NSMutableParagraphStyle{
                    paragraph.lineSpacing = spacing
                    attrs.updateValue(paragraph, forKey: .paragraphStyle)
                }else{
                    let paragraph = NSMutableParagraphStyle()
                    paragraph.lineSpacing = spacing
                    attrs.updateValue(paragraph, forKey: .paragraphStyle)
                }
                break
            case .paragraphSpacing(let spacing):
                if let paragraph = attrs[.paragraphStyle] as? NSMutableParagraphStyle{
                    paragraph.paragraphSpacing = spacing
                    attrs.updateValue(paragraph, forKey: .paragraphStyle)
                }else{
                    let paragraph = NSMutableParagraphStyle()
                    paragraph.paragraphSpacing = spacing
                    attrs.updateValue(paragraph, forKey: .paragraphStyle)
                }
                break
            case .alignment(let alignment):
                if let paragraph = attrs[.paragraphStyle] as? NSMutableParagraphStyle{
                   paragraph.alignment = alignment
                   attrs.updateValue(paragraph, forKey: .paragraphStyle)
               }else{
                   let paragraph = NSMutableParagraphStyle()
                   paragraph.alignment = alignment
                   attrs.updateValue(paragraph, forKey: .paragraphStyle)
               }
               break
            case .firstLineHeadIndent(let indent):
                if let paragraph = attrs[.paragraphStyle] as? NSMutableParagraphStyle{
                    paragraph.firstLineHeadIndent = indent
                    attrs.updateValue(paragraph, forKey: .paragraphStyle)
                }else{
                    let paragraph = NSMutableParagraphStyle()
                    paragraph.firstLineHeadIndent = indent
                    attrs.updateValue(paragraph, forKey: .paragraphStyle)
                }
                break
            case .headIndent(let indent):
                if let paragraph = attrs[.paragraphStyle] as? NSMutableParagraphStyle{
                    paragraph.headIndent = indent
                    attrs.updateValue(paragraph, forKey: .paragraphStyle)
                }else{
                    let paragraph = NSMutableParagraphStyle()
                    paragraph.headIndent = indent
                    attrs.updateValue(paragraph, forKey: .paragraphStyle)
                }
                break
            case .tailIndent(let indent):
                if let paragraph = attrs[.paragraphStyle] as? NSMutableParagraphStyle{
                    paragraph.tailIndent = indent
                    attrs.updateValue(paragraph, forKey: .paragraphStyle)
                }else{
                    let paragraph = NSMutableParagraphStyle()
                    paragraph.tailIndent = indent
                    attrs.updateValue(paragraph, forKey: .paragraphStyle)
                }
                break
            case .lineBreakMode(let breakmode):
                if let paragraph = attrs[.paragraphStyle] as? NSMutableParagraphStyle{
                    paragraph.lineBreakMode = breakmode
                    attrs.updateValue(paragraph, forKey: .paragraphStyle)
                }else{
                    let paragraph = NSMutableParagraphStyle()
                    paragraph.lineBreakMode = breakmode
                    attrs.updateValue(paragraph, forKey: .paragraphStyle)
                }
                break
            case .minimumLineHeight(let height):
                if let paragraph = attrs[.paragraphStyle] as? NSMutableParagraphStyle{
                    paragraph.minimumLineHeight = height
                    attrs.updateValue(paragraph, forKey: .paragraphStyle)
                }else{
                    let paragraph = NSMutableParagraphStyle()
                    paragraph.minimumLineHeight = height
                    attrs.updateValue(paragraph, forKey: .paragraphStyle)
                }
                break
            case .maximumLineHeight(let height):
                if let paragraph = attrs[.paragraphStyle] as? NSMutableParagraphStyle{
                    paragraph.maximumLineHeight = height
                    attrs.updateValue(paragraph, forKey: .paragraphStyle)
                }else{
                    let paragraph = NSMutableParagraphStyle()
                    paragraph.maximumLineHeight = height
                    attrs.updateValue(paragraph, forKey: .paragraphStyle)
                }
                break
            case .baseWritingDirection(let direction):
                if let paragraph = attrs[.paragraphStyle] as? NSMutableParagraphStyle{
                    paragraph.baseWritingDirection = direction
                    attrs.updateValue(paragraph, forKey: .paragraphStyle)
                }else{
                    let paragraph = NSMutableParagraphStyle()
                    paragraph.baseWritingDirection = direction
                    attrs.updateValue(paragraph, forKey: .paragraphStyle)
                }
                break
            case .lineHeightMultiple(let multiple):
                if let paragraph = attrs[.paragraphStyle] as? NSMutableParagraphStyle{
                    paragraph.lineHeightMultiple = multiple
                    attrs.updateValue(paragraph, forKey: .paragraphStyle)
                }else{
                    let paragraph = NSMutableParagraphStyle()
                    paragraph.lineHeightMultiple = multiple
                    attrs.updateValue(paragraph, forKey: .paragraphStyle)
                }
                break
            case .paragraphSpacingBefore(let spacing):
                if let paragraph = attrs[.paragraphStyle] as? NSMutableParagraphStyle{
                    paragraph.paragraphSpacingBefore = spacing
                    attrs.updateValue(paragraph, forKey: .paragraphStyle)
                }else{
                    let paragraph = NSMutableParagraphStyle()
                    paragraph.paragraphSpacingBefore = spacing
                    attrs.updateValue(paragraph, forKey: .paragraphStyle)
                }
                break
            case .hyphenationFactor(let factor):
                if let paragraph = attrs[.paragraphStyle] as? NSMutableParagraphStyle{
                    paragraph.hyphenationFactor = factor
                    attrs.updateValue(paragraph, forKey: .paragraphStyle)
                }else{
                    let paragraph = NSMutableParagraphStyle()
                    paragraph.hyphenationFactor = factor
                    attrs.updateValue(paragraph, forKey: .paragraphStyle)
                }
                break
            case .tabStops(let stops):
                if let paragraph = attrs[.paragraphStyle] as? NSMutableParagraphStyle{
                    paragraph.tabStops = stops
                    attrs.updateValue(paragraph, forKey: .paragraphStyle)
                }else{
                    let paragraph = NSMutableParagraphStyle()
                    paragraph.tabStops = stops
                    attrs.updateValue(paragraph, forKey: .paragraphStyle)
                }
                break
            case .defaultTabInterval(let interval):
                if let paragraph = attrs[.paragraphStyle] as? NSMutableParagraphStyle{
                    paragraph.defaultTabInterval = interval
                    attrs.updateValue(paragraph, forKey: .paragraphStyle)
                }else{
                    let paragraph = NSMutableParagraphStyle()
                    paragraph.defaultTabInterval = interval
                    attrs.updateValue(paragraph, forKey: .paragraphStyle)
                }
                break
            case .allowsDefaultTighteningForTruncation(let allows):
                if let paragraph = attrs[.paragraphStyle] as? NSMutableParagraphStyle{
                    paragraph.allowsDefaultTighteningForTruncation = allows
                    attrs.updateValue(paragraph, forKey: .paragraphStyle)
                }else{
                    let paragraph = NSMutableParagraphStyle()
                    paragraph.allowsDefaultTighteningForTruncation = allows
                    attrs.updateValue(paragraph, forKey: .paragraphStyle)
                }
                break
            }
        }
       return NSAttributedString(string: self, attributes: attrs)
    }
    
    
}
