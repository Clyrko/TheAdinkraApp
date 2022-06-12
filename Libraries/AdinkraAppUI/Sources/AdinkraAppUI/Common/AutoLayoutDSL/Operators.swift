import UIKit

public func +<A: LayoutAnchor>(lhs: A, rhs: CGFloat) -> (A, CGFloat) {
    return (lhs, rhs)
}

public func -<A: LayoutAnchor>(lhs: A, rhs: CGFloat) -> (A, CGFloat) {
    return (lhs, -rhs)
}

@discardableResult
public func ==<A: LayoutAnchor>(lhs: LayoutProperty<A>,
                         rhs: (A, CGFloat))->NSLayoutConstraint {
    return lhs.equal(to: rhs.0, offsetBy: rhs.1)
}

@discardableResult
public func ==<A: LayoutAnchor>(lhs: LayoutProperty<A>, rhs: A)->NSLayoutConstraint {
    return lhs.equal(to: rhs)
}

@discardableResult
public func >=<A: LayoutAnchor>(lhs: LayoutProperty<A>,
                         rhs: (A, CGFloat))->NSLayoutConstraint {
    return lhs.greaterThanOrEqual(to: rhs.0, offsetBy: rhs.1)
}

@discardableResult
public func >=<A: LayoutAnchor>(lhs: LayoutProperty<A>, rhs: A)->NSLayoutConstraint {
    return lhs.greaterThanOrEqual(to: rhs)
}

@discardableResult
public func <=<A: LayoutAnchor>(lhs: LayoutProperty<A>,
                         rhs: (A, CGFloat))->NSLayoutConstraint {
    return lhs.lessThanOrEqual(to: rhs.0, offsetBy: rhs.1)
}

@discardableResult
public func <=<A: LayoutAnchor>(lhs: LayoutProperty<A>, rhs: A)->NSLayoutConstraint {
    return lhs.lessThanOrEqual(to: rhs)
}

precedencegroup LexicalArithmeticDisambiguityPrecedence{
    lowerThan:ComparisonPrecedence
}

infix operator |=| : DefaultPrecedence

infix operator -- : LexicalArithmeticDisambiguityPrecedence

@discardableResult
public func |=|<A:LayoutAnchor>(lhs: LayoutProperty<A>, rhs: CGFloat)->NSLayoutConstraint{
    return lhs.equal(to: rhs)
    
}
