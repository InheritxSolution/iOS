//
//  LoginCoordinator.swift
//  Inheritx Solutions
//
//  Created by Inheritx on 02/05/26.
//  Copyright © 2026 Inheritx Solutions. All rights reserved.
//

import UIKit

/// Handles navigation for the authentication flow.
public final class LoginCoordinator: BaseCoordinator {
    
    public override func start() {
        let loginVC = LoginViewController.instantiate() // Assuming a storyboard helper
        loginVC.coordinator = self
        navigationController.pushViewController(loginVC, animated: true)
    }
    
    /// Navigates to the registration flow.
    func showRegistration() {
        Logger.info("Navigating to Registration...")
        // push RegistrationViewController
    }
    
    /// Navigates to the main dashboard after successful login.
    func finishLogin() {
        Logger.info("Login flow completed.")
        // Notify parent coordinator or switch root view controller
    }
}

// MARK: - Update LoginViewController to support Coordinator
extension LoginViewController {
    // In a real app, we would add 'weak var coordinator: LoginCoordinator?' to LoginViewController
    // To demonstrate the pattern here, we assume it's integrated.
}
