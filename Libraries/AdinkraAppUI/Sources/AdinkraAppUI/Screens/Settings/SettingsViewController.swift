import Foundation
import UIKit

private enum Constants {
    
}

class SettingsViewController: BaseViewController {
    private var pageHeader = TitleHeaderView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .styleWhite
        initializeView()
        layoutConstraint()
    }
}

//MARK: - LAYOUT
extension SettingsViewController {
    private func initializeView() {
        pageHeader.title = "Settings"
        
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
