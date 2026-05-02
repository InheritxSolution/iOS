//
//  ThemeManager.swift
//  Inheritx Solutions
//
//  Created by Inheritx on 02/05/26.
//  Copyright © 2026 Inheritx Solutions. All rights reserved.
//

import UIKit

/// A professional design system engine for Inheritx Solutions.
public final class ThemeManager {
    
    public static let shared = ThemeManager()
    
    private init() {}
    
    // MARK: - Colors
    public struct Colors {
        public static let primary = UIColor(red: 0.0, green: 0.47, blue: 0.83, alpha: 1.0) // Inheritx Blue
        public static let secondary = UIColor(red: 1.0, green: 0.84, blue: 0.0, alpha: 1.0) // Gold
        public static let background = UIColor.systemBackground
        public static let surface = UIColor.secondarySystemBackground
        public static let error = UIColor.systemRed
        public static let text = UIColor.label
        public static let subtext = UIColor.secondaryLabel
    }
    
    // MARK: - Typography
    public struct Typography {
        public static func heading1() -> UIFont {
            return UIFont.systemFont(ofSize: 32, weight: .bold)
        }
        
        public static func body() -> UIFont {
            return UIFont.systemFont(ofSize: 16, weight: .regular)
        }
        
        public static func caption() -> UIFont {
            return UIFont.systemFont(ofSize: 12, weight: .medium)
        }
    }
    
    // MARK: - Metrics
    public struct Metrics {
        public static let cornerRadius: CGFloat = 16.0
        public static let padding: CGFloat = 20.0
        public static let borderWidth: CGFloat = 1.0
    }
}
