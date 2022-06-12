import Foundation

public enum LogCategory: String {
    case presentation
    case ui
    case domainData
}

public enum LogType: Int {
    case fault
    case error
    case info
    case debug

    var tag: String {
        switch self {
        case .fault:
            return "[FAULT]"
        case .error:
            return "[ERROR]"
        case .info:
            return "[INFO]"
        case .debug:
            return "[DEBUG]"
        }
    }

    var level: Int {
        switch self {
        case .fault:
            return 4
        case .error:
            return 3
        case .info:
            return 2
        case .debug:
            return 1
        }
    }
}
