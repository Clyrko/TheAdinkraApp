import UIKit

extension CGPoint {
    func constrained(in bounds: CGRect) -> CGPoint {
        var x = self.x; var y = self.y
        if x < bounds.minX { x = bounds.minX } else if x > bounds.maxX {
            x = bounds.maxX
        }

        if y < bounds.minY { y = bounds.minY } else if y > bounds.maxY {
            y = bounds.maxY
        }
        return CGPoint(x: x, y: y)
    }
}
