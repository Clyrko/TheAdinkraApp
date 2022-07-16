import UIKit

public struct SymbolPresentationModel {
    public let id: Int
    public let symbol: UIImage
    public let title: String
    public let meaning: String
    public let description: String
    public let phonetic: String
    public let pronunciation: String
    public let categories: [String]
    public var isFavorite: Bool
}
