import Foundation
import Combine

public extension Collection {
    var isNotEmpty: Bool { !isEmpty }
}

@available(iOS 13.0, *)
public extension Collection where Element == AnyCancellable {
    func cancel() {
        forEach{ $0.cancel() }
    }
}
