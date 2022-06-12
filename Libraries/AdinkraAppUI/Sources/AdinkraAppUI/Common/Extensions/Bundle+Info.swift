import Foundation
import os.log

public extension Bundle {
    static func getString(for key: String) -> String? {
        guard let infoPlistpath = main.url(forResource: "Info", withExtension: "plist") else { return nil }
        do {
            let data = try Data(contentsOf: infoPlistpath)
            let dictionary = try PropertyListSerialization.propertyList(from: data, options: [], format: nil) as? [String: Any] ?? [:]
            return dictionary[key] as? String ?? nil
        } catch {
            print("🛑🛑🛑 Error thrown in \(#function) with signature: \(error)")
        }
        return nil
    }
}
