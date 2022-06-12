import Foundation

public extension Error {
    var debugDescription: String {
        return (self as NSError).debugDescription
    }
}
