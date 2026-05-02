//
//  User.swift
//  Inheritx Solutions
//
//  Created by Inheritx on 02/05/26.
//  Copyright © 2026 Inheritx Solutions. All rights reserved.
//

import Foundation

/// Represents a user entity in the domain.
public struct User: Codable {
    public let id: String
    public let email: String
    public let firstName: String?
    public let lastName: String?
    public let isSignupComplete: Bool
    public let token: String?
    
    public init(id: String, email: String, firstName: String? = nil, lastName: String? = nil, isSignupComplete: Bool = false, token: String? = nil) {
        self.id = id
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
        self.isSignupComplete = isSignupComplete
        self.token = token
    }
}
