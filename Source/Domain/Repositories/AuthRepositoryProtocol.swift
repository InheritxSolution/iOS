//
//  AuthRepositoryProtocol.swift
//  Inheritx Solutions
//
//  Created by Inheritx on 02/05/26.
//  Copyright © 2026 Inheritx Solutions. All rights reserved.
//

import Foundation

/// Defines the authentication operations available in the domain.
public protocol AuthRepositoryProtocol {
    func login(email: String, password: String) async -> Result<User, NetworkError>
    func logout()
}
