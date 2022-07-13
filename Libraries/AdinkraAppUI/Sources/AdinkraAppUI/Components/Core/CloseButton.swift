import UIKit

class CloseButton: UIButton {
    private let strokeColor: UIColor
    private let fillColor: UIColor
    
    init(
        frame: CGRect = .zero,
        stroke: UIColor = .styleBlack,
        fill: UIColor = .styleGray
    ) {
        self.strokeColor = stroke
        self.fillColor = fill
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
        
    override func draw(_ rect: CGRect) {
        let circle = UIBezierPath(ovalIn: rect)
        fillColor.setFill()
        circle.fill()
        let slash = UIBezierPath()
        let slash2 = UIBezierPath()
        slash2.lineCapStyle = .round
        slash2.lineWidth = 2
        slash.lineWidth = 2
        slash.lineCapStyle = .round
        slash.move(to: CGPoint(x: rect.width * (1/3), y: rect.height * (1/3)))
        slash.addLine(to: CGPoint(x: rect.width * (2 / 3), y: rect.height * (2/3)))
        
        slash2.move(to: CGPoint(x: rect.width * (2 / 3), y: rect.height * (1 / 3)))
        slash2.addLine(to: CGPoint(x: rect.width * (1 / 3), y: rect.height * (2 / 3)))
        strokeColor.setStroke()
        slash.stroke()
        slash2.stroke()
    }
}
