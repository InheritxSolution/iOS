//
//  MockAuthRepository.swift
//  Inheritx Solutions
//
//  Created by Inheritx on 02/05/26.
//  Copyright © 2026 Inheritx Solutions. All rights reserved.
//

import Foundation

/// A mock implementation of AuthRepository for unit testing.
public final class MockAuthRepository: AuthRepositoryProtocol {
    
    public var result: Result<User, NetworkError> = .failure(.unknown)
    public var loginCalled = false
    public var logoutCalled = false
    
    public func login(email: String, password: String) async -> Result<User, NetworkError> {
        loginCalled = true
        return result
    }
    
    public func logout() {
        logoutCalled = true
    }
}
