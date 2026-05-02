//
//  InheritxButton.swift
//  Inheritx Solutions
//
//  Created by Inheritx on 02/05/26.
//  Copyright © 2026 Inheritx Solutions. All rights reserved.
//

import UIKit

/// A premium, glassmorphic button component with built-in animations.
@IBDesignable
public final class InheritxButton: UIButton {
    
    // MARK: - Properties
    public override var isHighlighted: Bool {
        didSet {
            animateScale(isHighlighted ? 0.95 : 1.0)
        }
    }
    
    // MARK: - Initialization
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    // MARK: - Setup
    private func setup() {
        backgroundColor = ThemeManager.Colors.primary
        setTitleColor(.white, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        
        layer.cornerRadius = ThemeManager.Metrics.cornerRadius
        applyPremiumShadow()
        
        // Add a subtle gradient or blur effect if needed
    }
    
    private func animateScale(_ scale: CGFloat) {
        UIView.animate(withDuration: 0.2, delay: 0, options: [.allowUserInteraction, .beginFromCurrentState], animations: {
            self.transform = CGAffineTransform(scaleX: scale, y: scale)
        }, completion: nil)
    }
}
