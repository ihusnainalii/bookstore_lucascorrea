//
//  BaseCoordinator.swift
//  BookStore_LucasCorrea
//
//  Created by Lucas Correa on 06/08/2020.
//  Copyright © 2020 SiriusCode. All rights reserved.
//

import UIKit

class BaseCoordinator: Coordinator {
    
    //
    // MARK: - Properties
    var childCoordinators: [Coordinator] = []
    var parentCoordinator: Coordinator?
    var navigationController: UINavigationController
    
    //
    // MARK: - Init DI
    
    /// Init
    /// - Parameter navigationController: UINavigationController
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    //
    // MARK: - Public Functions
    
    /// Start a coordinator
    func start() {
        fatalError("Start method must be implemented")
    }
    
    /// Start a coordinator
    /// - Parameter coordinator: Coordinator
    func start(coordinator: Coordinator) {
        self.childCoordinators.append(coordinator)
        coordinator.parentCoordinator = self
        coordinator.start()
    }
    
    /// Finish a coordinator
    /// - Parameter coordinator: Coordinator
    func didFinish(coordinator: Coordinator) {
        if let index = self.childCoordinators.firstIndex(where: { $0 === coordinator }) {
            print("Removed \(coordinator.self)")
            self.childCoordinators.remove(at: index)
        }
    }
}
