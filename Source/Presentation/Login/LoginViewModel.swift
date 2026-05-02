//
//  LoginViewModel.swift
//  Inheritx Solutions
//
//  Created by Inheritx on 02/05/26.
//  Copyright © 2026 Inheritx Solutions. All rights reserved.
//

import Foundation

/// State of the Login view.
public enum LoginState {
    case idle
    case loading
    case success(User)
    case error(String)
}

/// ViewModel responsible for handling login logic and state.
public final class LoginViewModel {
    
    // MARK: - Properties
    private let authRepository: AuthRepositoryProtocol
    
    /// Binding closure to update the view state.
    public var onStateChange: ((LoginState) -> Void)?
    
    private(set) var state: LoginState = .idle {
        didSet {
            onStateChange?(state)
        }
    }
    
    // MARK: - Initialization
    public init(authRepository: AuthRepositoryProtocol = AuthRepository()) {
        self.authRepository = authRepository
    }
    
    // MARK: - Public Methods
    
    /// Performs the login operation.
    public func login(email: String, password: String) {
        guard validate(email: email, password: password) else { return }
        
        state = .loading
        
        Task {
            let result = await authRepository.login(email: email, password: password)
            
            DispatchQueue.main.async { [weak self] in
                switch result {
                case .success(let user):
                    Logger.info("Login successful for user: \(user.email)")
                    self?.state = .success(user)
                case .failure(let error):
                    Logger.error("Login failed: \(error.localizedDescription)")
                    self?.state = .error(error.localizedDescription)
                }
            }
        }
    }
    
    // MARK: - Private Methods
    
    private func validate(email: String, password: String) -> Bool {
        if email.isEmpty {
            state = .error("Email cannot be empty".localized)
            return false
        }
        if !email.isValidEmail() {
            state = .error("Please enter a valid email address".localized)
            return false
        }
        if password.isEmpty {
            state = .error("Password cannot be empty".localized)
            return false
        }
        return true
    }
}
