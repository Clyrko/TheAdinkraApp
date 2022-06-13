import UIKit


private enum Constants {
    static let width: CGFloat = 102
    static let horizontalInset: CGFloat = 24
    static let containerInsets = UIEdgeInsets(top: 16, left: 0, bottom: 16, right: 24)
    static let fullAlphaValue: CGFloat = 1
    static let animationDuration: CGFloat = 0.3
    static let cardTipSize = CGSize(width: 40, height: 15)
    static let cardTipBottomInset: CGFloat = 16
    static let cardHorizontalInset: CGFloat = 16
    static let cardHeight: CGFloat = 308
    static let tabHeight: CGFloat = 80
}

class BaseApplicationViewController: UIViewController {
    enum Tab: Int {
        case home, store, favorites, settings
    }
    private var viewControllers: [ContainedViewControllerProtocol] = []
    private var currentController: ContainedViewControllerProtocol!
    private var ftuxOverlay: UIView!
    private var ftuxCardTip: UIImageView!
    private var ftuxCard: FTUXTourCardView!
    private var ftuxCardTipXConstraint: NSLayoutConstraint?
    private var selectecdTintColor: UIColor = .mainOrange
    private var defaultTintColor: UIColor = .systemGray
    private var container = UIView()
    private var tabBar: TabBar!
    private var selectedIndex: Int = .zero
    private var ftuxCardItems: [FTUXTourCardView.UiModel]
    
    init(
        viewControllers: [ContainedViewControllerProtocol],
        ftuxCardItems: [FTUXTourCardView.UiModel]
    ){
        self.viewControllers = viewControllers
        self.ftuxCardItems = ftuxCardItems
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeView()
        addConstraint()
        setup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            //self.showFTUX()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func indexChanged(newIndex: Int){
        guard newIndex != selectedIndex else {
            currentController.popToRoot()
            return
        }
        selectedIndex = newIndex
        currentController.removeFrom()
        currentController = viewControllers[selectedIndex]
        addCurrentController()
    }
    
    private func setup(){
        currentController = viewControllers[.zero]
        addCurrentController()
        tabBar.changeTo(index: selectedIndex)
    }
    
    private func addCurrentController(){
        add(currentController, to: container)
        currentController.view.pintToAllSidesOf(container)
    }
    
    func setSelected(tab: Int){
        guard tab < viewControllers.count else { return }
        tabBar.select(tab: tab)
    }
    
    private func showFTUX() {
        setSelected(tab: .zero)
        tabBar.isUserInteractionEnabled = false
        ftuxOverlay = .init()
        ftuxOverlay.backgroundColor = .styleBlack.withAlphaComponent(0.7)
        ftuxCardTip = .init(image: .named("icon-ftux-card-pointer"))
        ftuxCardTip.contentMode = .scaleAspectFit
        
        ftuxCard = .init()
        ftuxCard.setup(with: ftuxCardItems[selectedIndex])
        
        view.addSubview(ftuxOverlay)
        view.addSubview(ftuxCard)
        view.addSubview(ftuxCardTip)
        ftuxCard.alpha = .zero
        ftuxOverlay.alpha = .zero
        ftuxCardTip.alpha = .zero
        
        ftuxOverlay.pintToAllSidesOf(container)
        ftuxCardTip.layout {
            $0.bottom == tabBar.topAnchor - Constants.cardTipBottomInset
            $0.height |=| Constants.cardTipSize.height
            $0.width |=| Constants.cardTipSize.width
        }
        ftuxCardTipXConstraint = ftuxCardTip.centerXAnchor.constraint(
            equalTo: tabBar.currentTab(at: selectedIndex).centerXAnchor)
        ftuxCardTipXConstraint?.isActive = true
        ftuxCard.layout {
            $0.leading == view.leadingAnchor + Constants.cardHorizontalInset
            $0.trailing == view.trailingAnchor - Constants.cardHorizontalInset
            $0.bottom == ftuxCardTip.topAnchor
            $0.height |=| Constants.cardHeight
        }
        ftuxCard.onNextAction = { [weak self] in
            self?.proceedToNextFTUX()
        }
        ftuxCard.onCloseAction = { [weak self] in
            self?.endFTUX()
        }
        ftuxCard.onDoneAction = { [weak self] in
            self?.endFTUX()
        }
        
        UIView.animate(
            withDuration: Constants.animationDuration,
            delay: .zero,
            options: .curveEaseInOut
        ) {
            self.ftuxCard.alpha = Constants.fullAlphaValue
            self.ftuxOverlay.alpha = Constants.fullAlphaValue
            self.ftuxCardTip.alpha = Constants.fullAlphaValue
        }
    }
    
    func animateLayout() {
        UIView.animate(
            withDuration: Constants.animationDuration, delay: .zero,
            options: .transitionCrossDissolve
        ) {
            self.view.layoutIfNeeded()
        }
    }
    
    private func proceedToNextFTUX() {
        let nextTab = selectedIndex + 1
        setSelected(tab: nextTab)
        ftuxCard.setup(with: ftuxCardItems[selectedIndex])
        ftuxCardTipXConstraint?.isActive = false
        ftuxCardTipXConstraint = ftuxCardTip.centerXAnchor.constraint(
            equalTo: tabBar.currentTab(at: selectedIndex).centerXAnchor
        )
        ftuxCardTipXConstraint?.isActive = true
        animateLayout()
    }
    
    private func endFTUX() {
        tabBar.isUserInteractionEnabled = true
        UIView.transition(
            with: view, duration: Constants.animationDuration,
            options: .transitionCrossDissolve
        ) {
            self.ftuxOverlay.removeFromSuperview()
            self.ftuxCard.removeFromSuperview()
            self.ftuxCardTip.removeFromSuperview()
        }
    }
}

extension BaseApplicationViewController {
    private func initializeView(){
        view.backgroundColor = .styleWhite
        let items = viewControllers.enumerated().map { index, value -> TabBarItem.UIModel in
            TabBarItem.UIModel(
                index: index,
                title: value.itemTitle,
                image: value.unselectedTabImage,
                selectedImage: value.selectedTabImage,
                selectedTint: selectecdTintColor,
                defaultTint: defaultTintColor
            )
        }
        
        tabBar = TabBar(items: items)
        
        container.backgroundColor = .clear
        
        tabBar.indexChanged = indexChanged(newIndex:)
        
        view.addSubview(container)
        view.addSubview(tabBar)
        
    }
    
    private func addConstraint(){
        tabBar.layout{
            $0.leading == view.leadingAnchor
            $0.height |=| Constants.tabHeight
            $0.bottom == view.bottomAnchor
            $0.trailing == view.trailingAnchor
        }
        
        container.layout{
            $0.leading == view.leadingAnchor
            $0.top == view.topAnchor
            $0.bottom == tabBar.topAnchor
            $0.trailing == view.trailingAnchor
        }
    }
}
