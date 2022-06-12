import Foundation

public extension String {
    var localized: String {
        NSLocalizedString(self, tableName: nil, bundle: .module, value: .init(), comment: .init())
    }
}
