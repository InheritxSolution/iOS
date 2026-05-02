//
//  BaseCoordinator.swift
//  Inheritx Solutions
//
//  Created by Inheritx on 02/05/26.
//  Copyright © 2026 Inheritx Solutions. All rights reserved.
//

import UIKit

/// A protocol that all coordinators must conform to.
public protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
}

/// A base implementation of the Coordinator pattern.
public class BaseCoordinator: Coordinator {
    public var childCoordinators: [Coordinator] = []
    public var navigationController: UINavigationController
    
    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    public func start() {
        fatalError("Start method must be implemented by subclasses")
    }
    
    /// Adds a child coordinator to the list.
    public func addChild(_ coordinator: Coordinator) {
        childCoordinators.append(coordinator)
    }
    
    /// Removes a child coordinator from the list.
    public func removeChild(_ coordinator: Coordinator) {
        childCoordinators = childCoordinators.filter { $0 !== coordinator }
    }
}
