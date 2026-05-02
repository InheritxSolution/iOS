//
//  StorageService.swift
//  Inheritx Solutions
//
//  Created by Inheritx on 02/05/26.
//  Copyright © 2026 Inheritx Solutions. All rights reserved.
//

import Foundation

/// Defines the operations for data persistence.
public protocol StorageServiceProtocol {
    func save<T: Encodable>(_ object: T, forKey key: String) throws
    func fetch<T: Decodable>(forKey key: String) -> T?
    func delete(forKey key: String)
    func clearAll()
}

/// A lightweight, thread-safe storage implementation using UserDefaults.
/// For larger datasets, this would be swapped with CoreData or SwiftData implementations.
public final class StorageService: StorageServiceProtocol {
    
    private let defaults: UserDefaults
    private let queue = DispatchQueue(label: "com.inheritx.storage", attributes: .concurrent)
    
    public init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
    }
    
    public func save<T: Encodable>(_ object: T, forKey key: String) throws {
        try queue.async(flags: .barrier) {
            let data = try JSONEncoder().encode(object)
            self.defaults.set(data, forKey: key)
        }
    }
    
    public func fetch<T: Decodable>(forKey key: String) -> T? {
        var result: T?
        queue.sync {
            guard let data = defaults.data(forKey: key) else { return }
            result = try? JSONDecoder().decode(T.self, from: data)
        }
        return result
    }
    
    public func delete(forKey key: String) {
        queue.async(flags: .barrier) {
            self.defaults.removeObject(forKey: key)
        }
    }
    
    public func clearAll() {
        queue.async(flags: .barrier) {
            let domain = Bundle.main.bundleIdentifier!
            self.defaults.removePersistentDomain(forName: domain)
        }
    }
}
