//
//  LoginViewController.swift
//  Inheritx Solutions
//
//  Created by Inheritx on 02/05/26.
//  Copyright © 2026 Inheritx Solutions. All rights reserved.
//

import UIKit

/// Refactored LoginViewController using MVVM pattern.
public final class LoginViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Properties
    private var viewModel: LoginViewModel!
    public weak var coordinator: LoginCoordinator?
    
    // MARK: - Lifecycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupViewModel()
    }
    
    /// Storyboard instantiation helper for the Coordinator pattern.
    public static func instantiate() -> LoginViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Logger.info("Login screen appeared.")
        txtEmail.becomeFirstResponder()
    }
    
    // MARK: - Setup
    private func setupUI() {
        title = "Login".localized
        
        // Apply premium styling from extensions
        txtEmail.roundCorners()
        txtEmail.addLeftPadding()
        txtEmail.applyPremiumShadow()
        
        txtPassword.roundCorners()
        txtPassword.addLeftPadding()
        txtPassword.applyPremiumShadow()
        
        btnLogin.roundCorners()
        btnLogin.applyPremiumShadow()
        
        txtEmail.delegate = self
        txtPassword.delegate = self
    }
    
    private func setupViewModel() {
        // Dependency Injection
        viewModel = LoginViewModel()
        
        // Binding to ViewModel state
        viewModel.onStateChange = { [weak self] state in
            self?.handleStateChange(state)
        }
    }
    
    // MARK: - Actions
    @IBAction func onLoginTap(_ sender: UIButton) {
        performLogin()
    }
    
    private func performLogin() {
        guard let email = txtEmail.text, let password = txtPassword.text else { return }
        viewModel.login(email: email, password: password)
    }
    
    // MARK: - State Handling
    private func handleStateChange(_ state: LoginState) {
        switch state {
        case .idle:
            stopLoading()
        case .loading:
            startLoading()
        case .success(let user):
            stopLoading()
            handleLoginSuccess(for: user)
        case .error(let message):
            stopLoading()
            showPremiumAlert(title: "Error".localized, message: message)
        }
    }
    
    private func startLoading() {
        activityIndicator.startAnimating()
        btnLogin.isEnabled = false
        btnLogin.alpha = 0.5
    }
    
    private func stopLoading() {
        activityIndicator.stopAnimating()
        btnLogin.isEnabled = true
        btnLogin.alpha = 1.0
    }
    
    private func handleLoginSuccess(for user: User) {
        Logger.info("Navigating to home for user: \(user.id)")
        // Navigation logic (e.g., via Coordinator)
        if user.isSignupComplete {
            dismiss(animated: true)
        } else {
            performSegue(withIdentifier: "segueRegistration", sender: nil)
        }
    }
}

// MARK: - UITextFieldDelegate
extension LoginViewController: UITextFieldDelegate {
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == txtEmail {
            txtPassword.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
            performLogin()
        }
        return true
    }
}
