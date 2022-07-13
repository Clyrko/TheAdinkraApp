import UIKit

private enum Constants {
    static let fontSize: CGFloat = 17
    static let cornerRadius: CGFloat = 8
    static let borderWidth: CGFloat = 1
    static let searchBarFontSize: CGFloat = 16
    static let height: CGFloat = 48
    static let edgeInsets: UIEdgeInsets = .init(top: 8, left: .zero, bottom: 8, right: .zero)
}


class StyleSearchBar: UIView {
    private var searchBar: UISearchBar!
    
    var onTextChanged: ((String) -> Void)?
    
    var color: UIColor? {
        didSet {
            backgroundColor = color
            searchBar.tintColor = color
            searchBar.searchTextField.backgroundColor = color
        }
    }
    
    var textColor: UIColor = .styleBlack {
        didSet {
            searchBar.searchTextField.textColor = textColor
        }
    }
    
    var placeholder: String = "" {
        didSet {
            searchBar.placeholder = placeholder
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        initializeView()
        layoutConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension StyleSearchBar {
     
    private func initializeView() {
        backgroundColor = .clear
        dropCorner(Constants.cornerRadius)
        borderlize(width: 1, color: .styleGray)

        searchBar = .init()
        searchBar.barTintColor = .styleBlack
        searchBar.backgroundImage = UIImage()
        searchBar.searchBarStyle = .prominent
        searchBar.searchTextField.backgroundColor =
            .styleWhite
        searchBar.searchTextField.font = .primary(weight: .regular, size: Constants.fontSize)
        searchBar.searchTextField.textColor = .styleBlack
        searchBar.placeholder = "Search"
        searchBar.delegate = self
        searchBar.returnKeyType = .search
        searchBar.searchTextField.delegate = self
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(searchBar)
    }
    
    private func layoutConstraint() {
        layout {
            $0.height |=| Constants.height
        }
        searchBar.pintToAllSidesOf(self, insets: Constants.edgeInsets)
    }
}


extension StyleSearchBar: UISearchBarDelegate, UITextFieldDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        onTextChanged?(searchText)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        endEditing(true)
    }
}
