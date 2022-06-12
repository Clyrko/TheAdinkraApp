import os.log
import Foundation

public class AppLogger {
    private static var sharedLoggers: [LogCategory: AppLogger] = [:]
    private let category: LogCategory
    private let log: OSLog
    var logLevel: LogType

    fileprivate init(category: LogCategory) {
        self.category = category
        let subsystem = Bundle.main.bundleIdentifier!
        switch category {
        case .presentation:
            self.log = OSLog(subsystem: subsystem, category: "PRESENTATION")
        case .ui:
            self.log = OSLog(subsystem: subsystem, category: "UI")
        case .domainData:
            self.log = OSLog(subsystem: subsystem, category: "DOMAIN_DATA")
        }
        #if DEBUG
        self.logLevel = .debug
        #else
        self.logLevel = .error
        #endif
    }

    public class func logger(for category: LogCategory) -> AppLogger {
        if let logger = sharedLoggers[category] {
            return logger
        }

        let logger = AppLogger(category: category)
        sharedLoggers[category] = logger

        return logger
    }

    public class func log(_ category: LogCategory,
                          _ type: LogType,
                          _ message: @autoclosure () -> Any,
                          _ privateMessage: String? = nil)
    {
        AppLogger.logger(for: category)
            .logMessage(type: type, message: message, privateMessage: privateMessage)
    }

    private func logMessage(type: LogType, message: () -> Any, privateMessage: String?) {
        guard type.level >= logLevel.level else { return }

        let nativeType = nativeLogType(type: type)
        let finalMessage = "\(type.tag) - \(message())"
        if let privateMessage = privateMessage {
            os_log("%{public}@. %{private}@", log: log, type: nativeType, finalMessage, privateMessage)
        } else {
            os_log("%{public}@", log: log, type: nativeType, finalMessage)
        }
    }

    private func nativeLogType(type: LogType) -> OSLogType {
        switch type {
        case .debug:
            return .debug
        case .error:
            return .error
        case .info:
            return .info
        case .fault:
            return .fault
        }
    }
}

extension AppLogger {
   
    public func d(message: String) {
        Self.log(.domainData, .debug, message)
    }
    
    public func e(message: String) {
        Self.log(.domainData, .error, message)
    }
    
    public func i(message: String) {
        Self.log(.domainData, .info, message)
    }
    
    public func v(message: String) {
        d(message: message)
    }
    
    public func w(message: String) {
        i(message: message)
    }
}

