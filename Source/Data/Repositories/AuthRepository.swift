//
//  AuthRepository.swift
//  Inheritx Solutions
//
//  Created by Inheritx on 02/05/26.
//  Copyright © 2026 Inheritx Solutions. All rights reserved.
//

import Foundation

/// Concrete implementation of authentication repository using the NetworkService.
public final class AuthRepository: AuthRepositoryProtocol {
    
    private let networkService: NetworkServiceProtocol
    
    public init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
    }
    
    public func login(email: String, password: String) async -> Result<User, NetworkError> {
        // In a real app, this would use a specific AuthEndpoint
        // For this showcase, we simulate the request or use a placeholder path
        let endpoint = AuthEndpoint.login(email: email, password: password)
        return await networkService.request(endpoint)
    }
    
    public func logout() {
        Logger.info("User logged out.")
        // Clear local session logic here
    }
}

// MARK: - Auth Endpoint Definition
enum AuthEndpoint: Endpoint {
    case login(email: String, password: String)
    
    var baseURL: URL { URL(string: "https://api.inheritx.com/v1")! }
    
    var path: String {
        switch self {
        case .login: return "auth/login"
        }
    }
    
    var method: HTTPMethod { .post }
    
    var headers: [String: String]? {
        ["Content-Type": "application/json"]
    }
    
    var body: Data? {
        switch self {
        case .login(let email, let password):
            let params = ["email": email, "password": password]
            return try? JSONSerialization.data(withJSONObject: params)
        }
    }
}
