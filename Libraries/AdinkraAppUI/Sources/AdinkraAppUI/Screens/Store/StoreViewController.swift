import Foundation
import UIKit

private enum Constants {
    
}

class StoreViewController: BaseViewController {
    private var pageHeader = TitleHeaderView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .styleWhite
        initializeView()
        layoutConstraint()
    }
}

//MARK: - LAYOUT
extension StoreViewController {
    private func initializeView() {
        pageHeader.title = "Store"
        
        view.addSubview(pageHeader)
    }
    
    private func layoutConstraint() {
        pageHeader.layout {
            $0.top == view.topAnchor
            $0.leading == view.leadingAnchor
            $0.trailing == view.trailingAnchor
        }
    }
}

