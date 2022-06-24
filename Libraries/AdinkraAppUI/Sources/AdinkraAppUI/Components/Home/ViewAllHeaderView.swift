import Foundation
 import UIKit

 private enum Constants {
     
 }

 class ViewAllHeaderView: UIControl {
     private var titleLabel: StyleLabel!
     private var viewAllButton: StyleButton!
     
     var onViewAllAction: Closure.Block?
     
     var title: String? {
         didSet { titleLabel.text = title }
     }

     override init(frame: CGRect) {
         super.init(frame: frame)
         initializeViews()
         layoutConstraints()
     }

     required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
     
     @objc private func onTapAction(sender: UIControl){
         self.onViewAllAction?()
     }
 }

 // MARK: - LAYOUT
 extension ViewAllHeaderView {
     private func initializeViews() {
         addTarget(self, action: #selector(onTapAction(sender:)), for: .touchUpInside)
         titleLabel = .init(
            with: .header2,
            textColor: .styleBlack,
            textAlignment: .left
         )
         
         viewAllButton = .init(with: .primaryDefault, title: "View All")
         viewAllButton.backgroundColor = .clear
         viewAllButton.titleColor = .styleBlack
         
         addSubview(titleLabel)
         addSubview(viewAllButton)
     }

     private func layoutConstraints() {
         titleLabel.layout {
             $0.top == topAnchor + 8
             $0.leading == leadingAnchor + 30
             $0.bottom == bottomAnchor - 4
         }
         
         viewAllButton.layout {
             $0.centerY == titleLabel.centerYAnchor
             $0.trailing == trailingAnchor - 30
         }
     }
 }
