//
//  UIExtensions.swift
//  Inheritx Solutions
//
//  Created by Inheritx on 02/05/26.
//  Copyright © 2026 Inheritx Solutions. All rights reserved.
//

import UIKit

extension UIView {
    /// Adds a premium shadow effect typical of high-end iOS apps.
    func applyPremiumShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowRadius = 12
        layer.masksToBounds = false
    }
    
    /// Adds a smooth corner radius.
    func roundCorners(radius: CGFloat = 12) {
        layer.cornerRadius = radius
        layer.masksToBounds = true
    }
}

extension UITextField {
    /// Adds a left padding to the text field for better readability.
    func addLeftPadding(_ padding: CGFloat = 12) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: frame.height))
        leftView = paddingView
        leftViewMode = .always
    }
}

extension String {
    /// Validates if the string is a valid email address using Regex.
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }
    
    /// Returns the localized version of the string.
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}

extension UIViewController {
    /// Shows a premium alert with a customized look and feel.
    func showPremiumAlert(title: String, message: String, actionTitle: String = "OK") {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: actionTitle, style: .default))
        present(alert, animated: true)
    }
}
