import UIKit

private enum Constants {
    static let titleFontSize: CGFloat = 14
    static let numberOfSections: Int = 1
    static let horizontalInset: CGFloat = 8
    static let verticalInset: CGFloat = 8
    static let tabSize = CGSize(width: 24, height: 2)
    static let estimatedItemSize = CGSize(width: 90, height: 75)
    static let shadowRadius: CGFloat = 2
    static let shadowOpacity: Float = 0.08
    static let shadowSize = CGSize(width: .zero, height: -2)
    static let indicatorCornerRadius: CGFloat = 1
}

class TabBar: UIView {
    private var tabIndicator = UIView()
    private var stackView: UIStackView!
    private var tabCenterXConstraint: NSLayoutConstraint?
    private var barItems:[TabBarItem.UIModel] = []
    private var tabs: [TabBarItem] {
        return stackView.arrangedSubviews as? [TabBarItem] ?? []
    }
    var indexChanged: ((Int) -> Void)?

    private override init(frame: CGRect) {
        super.init(frame: frame)
        initializeView()
        addConstraint()
    }
    
     init(items: [TabBarItem.UIModel]){
        self.barItems = items
        super.init(frame: .zero)
        initializeView()
        addConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func changeTo(index: Int){
        tabs.forEach{ $0.isSelected = false }
        tabs[index].isSelected = true
        animateToCurrentTab(index: index)
    }
    
    func select(tab: Int){
        guard tab < barItems.count else { return }
        changeTo(index: tab)
        indexChanged?(tab)
    }
    
    func animateToCurrentTab(index: Int) {
        let tab = tabs[index]
        tabCenterXConstraint?.isActive = false
        tabCenterXConstraint = tabIndicator.centerXAnchor.constraint(equalTo: tab.centerXAnchor)
        tabCenterXConstraint?.isActive = true
        UIView.animate(
            withDuration: 0.3,
            delay: .zero,
            options: .curveEaseOut
        ) {
            self.layoutIfNeeded()
        }

    }
    
    func currentTab(at index: Int) -> UIView {
        tabs[index]
    }
}


extension TabBar {
    private func initializeView(){
        backgroundColor = .styleWhite
        dropShadow(
            Constants.shadowRadius,
            color: .styleBlack,
            Constants.shadowOpacity,
            Constants.shadowSize
        )
        
        tabIndicator.backgroundColor = .mainOrange
        tabIndicator.dropCorner(Constants.indicatorCornerRadius)
        
        let tabs = barItems.map { model -> TabBarItem in
            let tab = TabBarItem(model: model)
            tab.onSelected = { [weak self] index in
                self?.select(tab: index)
            }
            return tab
        }
        stackView = .stack(
            views: tabs,
            axis: .horizontal,
            alignment: .center,
            distribution: .equalSpacing,
            spacing: .zero
        )
        
        addSubview(stackView)
        addSubview(tabIndicator)
    }
    
    private func addConstraint(){
        tabIndicator.layout{
            $0.width |=| Constants.tabSize.width
            $0.top == topAnchor
            $0.height |=| Constants.tabSize.height
        }

        stackView.layout{
            $0.leading == leadingAnchor
            $0.trailing == trailingAnchor
            let bottom = $0.bottom == bottomAnchor - 20
            bottom.priority = .defaultHigh
        }
    }
}
