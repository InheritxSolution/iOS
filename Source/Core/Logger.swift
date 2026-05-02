//
//  Logger.swift
//  Inheritx Solutions
//
//  Created by Inheritx on 02/05/26.
//  Copyright © 2026 Inheritx Solutions. All rights reserved.
//

import Foundation
import os.log

/// A premium logging utility for enterprise-grade debugging.
public enum Logger {
    
    enum LogLevel: String {
        case debug = "🔍 DEBUG"
        case info = "ℹ️ INFO"
        case warning = "⚠️ WARNING"
        case error = "❌ ERROR"
    }
    
    private static let subsystem = Bundle.main.bundleIdentifier ?? "com.inheritx.ios"
    
    /// Logs a message with a specific level.
    static func log(_ message: String, level: LogLevel = .debug, file: String = #file, function: String = #function, line: Int = #line) {
        #if DEBUG
        let fileName = (file as NSString).lastPathComponent
        let logMessage = "[\(level.rawValue)] [\(fileName):\(line)] \(function) -> \(message)"
        
        let type: OSLogType
        switch level {
        case .debug: type = .debug
        case .info: type = .info
        case .warning: type = .default
        case .error: type = .error
        }
        
        os_log("%{public}@", log: OSLog(subsystem: subsystem, category: level.rawValue), type: type, logMessage)
        #endif
    }
    
    static func debug(_ message: String) { log(message, level: .debug) }
    static func info(_ message: String) { log(message, level: .info) }
    static func warning(_ message: String) { log(message, level: .warning) }
    static func error(_ message: String) { log(message, level: .error) }
}
